import contextlib
import importlib.util
import io
import pathlib
import shutil
import tempfile
import unittest
from unittest import mock


ROOT = pathlib.Path(__file__).resolve().parents[1]
SCRIPT_PATH = ROOT / "scripts" / "sync_pixiv_swiftui_release.py"
CASK_PATH = ROOT / "Casks" / "pixiv-swiftui.rb"


def load_module():
    if not SCRIPT_PATH.exists():
        raise AssertionError(f"missing script: {SCRIPT_PATH}")

    spec = importlib.util.spec_from_file_location("sync_pixiv_swiftui_release", SCRIPT_PATH)
    if spec is None or spec.loader is None:
        raise AssertionError(f"unable to load script: {SCRIPT_PATH}")

    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def sample_payload(version="0.13.0"):
    return {
        "tag_name": f"v{version}",
        "assets": [
            {
                "name": "Pixiv-SwiftUI-arm64.dmg",
                "digest": "sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
            },
            {
                "name": "Pixiv-SwiftUI-x86_64.dmg",
                "digest": "sha256:bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
            },
        ],
    }


class SyncPixivSwiftUIReleaseTests(unittest.TestCase):
    def test_fetch_latest_release_includes_authorization_header_when_token_present(self):
        module = load_module()

        response = mock.MagicMock()
        response.__enter__.return_value = io.StringIO('{"tag_name": "v0.13.0", "assets": []}')
        response.__exit__.return_value = False

        with mock.patch.dict("os.environ", {"GITHUB_TOKEN": "test-token"}, clear=False):
            with mock.patch.object(module.urllib.request, "urlopen", return_value=response) as urlopen:
                module.fetch_latest_release()

        request = urlopen.call_args.args[0]
        self.assertEqual(request.get_header("Authorization"), "Bearer test-token")

    def test_extract_release_info_normalizes_tag_and_digests(self):
        module = load_module()

        release = module.extract_release_info(sample_payload())

        self.assertEqual(release["version"], "0.13.0")
        self.assertEqual(
            release["sha256"],
            {
                "arm": "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                "intel": "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
            },
        )

    def test_main_returns_nonzero_for_malformed_digest_content(self):
        module = load_module()

        bad_payload = sample_payload()
        bad_payload["assets"][0]["digest"] = "sha256:not-a-valid-digest"

        with tempfile.TemporaryDirectory() as tmpdir:
            tmp_cask = pathlib.Path(tmpdir) / "pixiv-swiftui.rb"
            shutil.copyfile(CASK_PATH, tmp_cask)
            original = tmp_cask.read_text(encoding="utf-8")
            stdout = io.StringIO()
            stderr = io.StringIO()

            with contextlib.redirect_stdout(stdout), contextlib.redirect_stderr(stderr):
                exit_code = module.main(
                    ["--cask", str(tmp_cask)],
                    fetch_release=lambda: bad_payload,
                )

            self.assertNotEqual(exit_code, 0)
            self.assertEqual(stdout.getvalue(), "")
            self.assertIn("digest", stderr.getvalue().lower())
            self.assertEqual(tmp_cask.read_text(encoding="utf-8"), original)

    def test_update_cask_contents_rewrites_version_and_hashes(self):
        module = load_module()

        updated = module.update_cask_contents(
            CASK_PATH.read_text(encoding="utf-8"),
            {
                "version": "0.13.0",
                "sha256": {
                    "arm": "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                    "intel": "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
                },
            },
        )

        self.assertIn('version "0.13.0"', updated)
        self.assertIn(
            'sha256 arm:   "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",',
            updated,
        )
        self.assertIn(
            '         intel: "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"',
            updated,
        )

    def test_update_cask_contents_handles_formatting_changes(self):
        module = load_module()

        cask_text = (
            "cask \"pixiv-swiftui\" do\n"
            "  version \"0.12.0\"\n"
            "    sha256 arm: \"old-arm\",\n"
            "      intel: \"old-intel\"\n"
            "end\n"
        )

        updated = module.update_cask_contents(
            cask_text,
            {
                "version": "0.13.0",
                "sha256": {
                    "arm": "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                    "intel": "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
                },
            },
        )

        self.assertIn('  version "0.13.0"', updated)
        self.assertIn(
            '  sha256 arm:   "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",',
            updated,
        )
        self.assertIn(
            '         intel: "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"',
            updated,
        )

    def test_main_dry_run_does_not_modify_cask(self):
        module = load_module()

        with tempfile.TemporaryDirectory() as tmpdir:
            tmp_cask = pathlib.Path(tmpdir) / "pixiv-swiftui.rb"
            shutil.copyfile(CASK_PATH, tmp_cask)
            original = tmp_cask.read_text(encoding="utf-8")
            stdout = io.StringIO()
            stderr = io.StringIO()

            with contextlib.redirect_stdout(stdout), contextlib.redirect_stderr(stderr):
                exit_code = module.main(
                    ["--dry-run", "--cask", str(tmp_cask)],
                    fetch_release=lambda: sample_payload(),
                )

            self.assertEqual(exit_code, 0)
            self.assertEqual(tmp_cask.read_text(encoding="utf-8"), original)
            self.assertIn("Would update", stdout.getvalue())
            self.assertEqual(stderr.getvalue(), "")

    def test_main_reports_noop_only_when_cask_content_is_unchanged(self):
        module = load_module()

        with tempfile.TemporaryDirectory() as tmpdir:
            tmp_cask = pathlib.Path(tmpdir) / "pixiv-swiftui.rb"
            shutil.copyfile(CASK_PATH, tmp_cask)
            stdout = io.StringIO()
            stderr = io.StringIO()

            with contextlib.redirect_stdout(stdout), contextlib.redirect_stderr(stderr):
                exit_code = module.main(
                    ["--cask", str(tmp_cask)],
                    fetch_release=lambda: sample_payload(version="0.12.0"),
                )

            self.assertEqual(exit_code, 0)
            self.assertIn("Updated", stdout.getvalue())
            self.assertIn(
                'sha256 arm:   "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",',
                tmp_cask.read_text(encoding="utf-8"),
            )
            self.assertEqual(stderr.getvalue(), "")

    def test_main_reports_noop_when_cask_content_is_already_current(self):
        module = load_module()

        with tempfile.TemporaryDirectory() as tmpdir:
            tmp_cask = pathlib.Path(tmpdir) / "pixiv-swiftui.rb"
            tmp_cask.write_text(
                module.update_cask_contents(
                    CASK_PATH.read_text(encoding="utf-8"),
                    {
                        "version": "0.12.0",
                        "sha256": {
                            "arm": "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                            "intel": "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
                        },
                    },
                ),
                encoding="utf-8",
            )
            stdout = io.StringIO()
            stderr = io.StringIO()

            with contextlib.redirect_stdout(stdout), contextlib.redirect_stderr(stderr):
                exit_code = module.main(
                    ["--cask", str(tmp_cask)],
                    fetch_release=lambda: sample_payload(version="0.12.0"),
                )

            self.assertEqual(exit_code, 0)
            self.assertIn("Already up to date", stdout.getvalue())
            self.assertEqual(stderr.getvalue(), "")

    def test_main_returns_nonzero_for_missing_digest(self):
        module = load_module()

        bad_payload = sample_payload()
        bad_payload["assets"][1] = {"name": "Pixiv-SwiftUI-x86_64.dmg"}

        with tempfile.TemporaryDirectory() as tmpdir:
            tmp_cask = pathlib.Path(tmpdir) / "pixiv-swiftui.rb"
            shutil.copyfile(CASK_PATH, tmp_cask)
            stdout = io.StringIO()
            stderr = io.StringIO()

            with contextlib.redirect_stdout(stdout), contextlib.redirect_stderr(stderr):
                exit_code = module.main(
                    ["--cask", str(tmp_cask)],
                    fetch_release=lambda: bad_payload,
                )

            self.assertNotEqual(exit_code, 0)
            self.assertEqual(stdout.getvalue(), "")
            self.assertIn("missing digest", stderr.getvalue().lower())


if __name__ == "__main__":
    unittest.main()

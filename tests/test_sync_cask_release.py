import contextlib
import email.message
import importlib.util
import io
import pathlib
import shutil
import tempfile
import unittest
import urllib.error
from unittest import mock


ROOT = pathlib.Path(__file__).resolve().parents[1]
SCRIPT_PATH = ROOT / "scripts" / "sync_cask_release.py"
CASK_PATH = ROOT / "Casks" / "pixiv-swiftui.rb"
OPENKARA_CASK_PATH = ROOT / "Casks" / "openkara.rb"


def load_module():
    if not SCRIPT_PATH.exists():
        raise AssertionError(f"missing script: {SCRIPT_PATH}")

    spec = importlib.util.spec_from_file_location("sync_cask_release", SCRIPT_PATH)
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


def sample_openkara_payload(version="1.2.3"):
    return {
        "tag_name": f"v{version}",
        "assets": [
            {
                "name": "OpenKara-arm64.dmg",
                "digest": "sha256:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc",
            },
            {
                "name": "OpenKara-x86_64.dmg",
                "digest": "sha256:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
            },
        ],
    }


class SyncPixivSwiftUIReleaseTests(unittest.TestCase):
    def test_app_config_contains_pixiv_swiftui_and_openkara(self):
        module = load_module()

        self.assertEqual(set(module.APPS), {"pixiv-swiftui", "openkara"})
        self.assertEqual(module.APPS["pixiv-swiftui"]["repo_slug"], "Eslzzyl/Pixiv-SwiftUI")
        self.assertEqual(module.APPS["pixiv-swiftui"]["cask_path"], ROOT / "Casks" / "pixiv-swiftui.rb")
        self.assertEqual(
            module.APPS["pixiv-swiftui"]["asset_names"],
            {
                "arm": "Pixiv-SwiftUI-arm64.dmg",
                "intel": "Pixiv-SwiftUI-x86_64.dmg",
            },
        )
        self.assertEqual(module.APPS["openkara"]["repo_slug"], "thedavidweng/OpenKara")
        self.assertEqual(module.APPS["openkara"]["cask_path"], ROOT / "Casks" / "openkara.rb")
        self.assertEqual(
            module.APPS["openkara"]["asset_names"],
            {
                "arm": "OpenKara-arm64.dmg",
                "intel": "OpenKara-x86_64.dmg",
            },
        )

    def test_fetch_latest_release_includes_authorization_header_when_token_present(self):
        module = load_module()

        response = mock.MagicMock()
        response.__enter__.return_value = io.StringIO('{"tag_name": "v0.13.0", "assets": []}')
        response.__exit__.return_value = False

        with mock.patch.dict("os.environ", {"GITHUB_TOKEN": "test-token"}, clear=False):
            with mock.patch.object(module.urllib.request, "urlopen", return_value=response) as urlopen:
                module.fetch_latest_release(module.APPS["pixiv-swiftui"])

        request = urlopen.call_args.args[0]
        self.assertEqual(request.get_header("Authorization"), "Bearer test-token")

    def test_fetch_latest_release_passes_explicit_timeout_to_urlopen(self):
        module = load_module()

        response = mock.MagicMock()
        response.__enter__.return_value = io.StringIO('{"tag_name": "v0.13.0", "assets": []}')
        response.__exit__.return_value = False

        with mock.patch.object(module.urllib.request, "urlopen", return_value=response) as urlopen:
            module.fetch_latest_release(module.APPS["pixiv-swiftui"])

        self.assertIn("timeout", urlopen.call_args.kwargs)
        self.assertEqual(urlopen.call_args.kwargs["timeout"], 30)

    def test_configured_cask_files_exist_and_are_readable_for_all_apps(self):
        module = load_module()

        for app in module.APPS.values():
            self.assertTrue(app["cask_path"].exists())
            self.assertTrue(module.current_version(app["cask_path"].read_text(encoding="utf-8")))

    def test_extract_release_info_uses_selected_app_asset_names(self):
        module = load_module()

        release = module.extract_release_info(sample_openkara_payload(), module.APPS["openkara"])

        self.assertEqual(release["version"], "1.2.3")
        self.assertEqual(
            release["sha256"],
            {
                "arm": "cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc",
                "intel": "dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
            },
        )

    def test_extract_release_info_normalizes_tag_and_digests(self):
        module = load_module()

        release = module.extract_release_info(sample_payload(), module.APPS["pixiv-swiftui"])

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
                    fetch_release=lambda app: bad_payload,
                )

            self.assertNotEqual(exit_code, 0)
            self.assertEqual(stdout.getvalue(), "")
            self.assertIn("digest", stderr.getvalue().lower())
            self.assertEqual(tmp_cask.read_text(encoding="utf-8"), original)

    def test_update_cask_contents_rewrites_version_and_hashes(self):
        module = load_module()

        updated = module.update_cask_contents(
            CASK_PATH.read_text(encoding="utf-8"),
            module.APPS["pixiv-swiftui"],
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
            module.APPS["pixiv-swiftui"],
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

    def test_update_cask_contents_only_replaces_sha256_intel_line(self):
        module = load_module()

        cask_text = (
            'cask "pixiv-swiftui" do\n'
            '  version "0.12.0"\n'
            '  intel: "keep-me"\n'
            '  sha256 arm:   "old-arm",\n'
            '         intel: "old-intel"\n'
            "end\n"
        )

        updated = module.update_cask_contents(
            cask_text,
            module.APPS["pixiv-swiftui"],
            {
                "version": "0.13.0",
                "sha256": {
                    "arm": "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                    "intel": "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
                },
            },
        )

        self.assertIn('  intel: "keep-me"', updated)
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
                    fetch_release=lambda app: sample_payload(),
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
                    fetch_release=lambda app: sample_payload(version="0.12.0"),
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
                    module.APPS["pixiv-swiftui"],
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
                    fetch_release=lambda app: sample_payload(version="0.12.0"),
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
                    fetch_release=lambda app: bad_payload,
                )

            self.assertNotEqual(exit_code, 0)
            self.assertEqual(stdout.getvalue(), "")
            self.assertIn("missing digest", stderr.getvalue().lower())

    def test_main_uses_selected_app_config(self):
        module = load_module()
        called_apps = []

        with tempfile.TemporaryDirectory() as tmpdir:
            tmp_cask = pathlib.Path(tmpdir) / "openkara.rb"
            tmp_cask.write_text(
                (
                    'cask "openkara" do\n'
                    '  version "1.0.0"\n'
                    '  sha256 arm:   "old-arm",\n'
                    '         intel: "old-intel"\n'
                    "end\n"
                ),
                encoding="utf-8",
            )
            stdout = io.StringIO()
            stderr = io.StringIO()

            def fetch_release(app):
                called_apps.append(app)
                return sample_openkara_payload()

            with contextlib.redirect_stdout(stdout), contextlib.redirect_stderr(stderr):
                exit_code = module.main(
                    ["--app", "openkara", "--cask", str(tmp_cask)],
                    fetch_release=fetch_release,
                )

            self.assertEqual(exit_code, 0)
            self.assertEqual(called_apps, [module.APPS["openkara"]])
            self.assertIn("Updated", stdout.getvalue())
            self.assertIn('version "1.2.3"', tmp_cask.read_text(encoding="utf-8"))
            self.assertEqual(stderr.getvalue(), "")

    def test_main_supports_repeated_app_flags(self):
        module = load_module()
        called_apps = []

        with tempfile.TemporaryDirectory() as tmpdir:
            tmpdir_path = pathlib.Path(tmpdir)
            pixiv_cask = tmpdir_path / "pixiv-swiftui.rb"
            openkara_cask = tmpdir_path / "openkara.rb"
            shutil.copyfile(CASK_PATH, pixiv_cask)
            shutil.copyfile(OPENKARA_CASK_PATH, openkara_cask)
            stdout = io.StringIO()
            stderr = io.StringIO()

            def fetch_release(app):
                called_apps.append(app["repo_slug"])
                if app["repo_slug"] == module.APPS["pixiv-swiftui"]["repo_slug"]:
                    return sample_payload(version="0.13.0")
                return sample_openkara_payload(version="1.2.3")

            with mock.patch.dict(
                module.APPS,
                {
                    "pixiv-swiftui": {**module.APPS["pixiv-swiftui"], "cask_path": pixiv_cask},
                    "openkara": {**module.APPS["openkara"], "cask_path": openkara_cask},
                },
            ):
                with contextlib.redirect_stdout(stdout), contextlib.redirect_stderr(stderr):
                    exit_code = module.main(
                        ["--app", "pixiv-swiftui", "--app", "openkara"],
                        fetch_release=fetch_release,
                    )

            self.assertEqual(exit_code, 0)
            self.assertEqual(
                called_apps,
                [
                    module.APPS["pixiv-swiftui"]["repo_slug"],
                    module.APPS["openkara"]["repo_slug"],
                ],
            )
            self.assertIn('version "0.13.0"', pixiv_cask.read_text(encoding="utf-8"))
            self.assertIn('version "1.2.3"', openkara_cask.read_text(encoding="utf-8"))
            self.assertEqual(stderr.getvalue(), "")

    def test_main_skips_missing_latest_release_for_openkara(self):
        module = load_module()
        stdout = io.StringIO()
        stderr = io.StringIO()

        def fetch_release(app):
            raise urllib.error.HTTPError(
                url=f"https://api.github.com/repos/{app['repo_slug']}/releases/latest",
                code=404,
                msg="Not Found",
                hdrs=email.message.Message(),
                fp=io.BytesIO(),
            )

        with contextlib.redirect_stdout(stdout), contextlib.redirect_stderr(stderr):
            exit_code = module.main(["--app", "openkara"], fetch_release=fetch_release)

        self.assertEqual(exit_code, 0)
        self.assertIn("Skipping openkara", stdout.getvalue())
        self.assertEqual(stderr.getvalue(), "")

    def test_main_returns_nonzero_for_missing_latest_release_for_pixiv_swiftui(self):
        module = load_module()
        stdout = io.StringIO()
        stderr = io.StringIO()

        def fetch_release(app):
            raise urllib.error.HTTPError(
                url=f"https://api.github.com/repos/{app['repo_slug']}/releases/latest",
                code=404,
                msg="Not Found",
                hdrs=email.message.Message(),
                fp=io.BytesIO(),
            )

        with contextlib.redirect_stdout(stdout), contextlib.redirect_stderr(stderr):
            exit_code = module.main(["--app", "pixiv-swiftui"], fetch_release=fetch_release)

        self.assertNotEqual(exit_code, 0)
        self.assertEqual(stdout.getvalue(), "")
        self.assertIn("404", stderr.getvalue())


if __name__ == "__main__":
    unittest.main()

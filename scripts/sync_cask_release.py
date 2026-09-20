#!/usr/bin/env python3

import argparse
import json
import os
import pathlib
import re
import sys
import urllib.error
import urllib.request


ROOT = pathlib.Path(__file__).resolve().parents[1]
REQUEST_TIMEOUT_SECONDS = 30
APPS = {
    "pixiv-swiftui": {
        "repo_slug": "Eslzzyl/Pixiv-SwiftUI",
        "cask_path": ROOT / "Casks" / "pixiv-swiftui.rb",
        "asset_names": {
            "arm": "Pixiv-SwiftUI-arm64.dmg",
            "intel": "Pixiv-SwiftUI-x86_64.dmg",
        },
    },
    "openkara": {
        "repo_slug": "thedavidweng/OpenKara",
        "cask_path": ROOT / "Casks" / "openkara.rb",
        "asset_patterns": {
            "arm": "_aarch64.dmg",
            "intel": "_x64.dmg",
        },
    },
    "screenize": {
        "repo_slug": "syi0808/screenize",
        "cask_path": ROOT / "Casks" / "screenize.rb",
        "asset_name": "Screenize.dmg",
    },
    "fluidvoice": {
        "repo_slug": "altic-dev/FluidVoice",
        "cask_path": ROOT / "Casks" / "fluidvoice.rb",
        "asset_name_template": "Fluid-oss-{version}.dmg",
        # 上游仓库同时发布 Windows 系 tag（windows-*、windows-latest），而
        # /releases/latest 按发布时间取最新，会命中 Windows 专属 release。
        # 只接受稳定版 macOS tag，避免把 cask 指向含 .exe 的 release。
        "tag_pattern": r"^v\d+\.\d+\.\d+$",
    },
    "openloop": {
        "repo_slug": "thedavidweng/OpenLoop",
        "cask_path": ROOT / "Casks" / "openloop.rb",
        "asset_name_template": "OpenLoop_{version}_aarch64.dmg",
    },
    "apple-say": {
        "repo_slug": "thedavidweng/apple-say",
        "cask_path": ROOT / "Casks" / "apple-say.rb",
        "asset_name": "Apple-Say.dmg",
    },
    "sukiru": {
        "repo_slug": "thedavidweng/gino",
        "cask_path": ROOT / "Casks" / "sukiru.rb",
        "asset_name": "Sukiru.dmg",
    },
    "tg-drive-cli": {
        "repo_slug": "thedavidweng/tg-drive-cli",
        "cask_path": ROOT / "Casks" / "tg-drive-cli.rb",
        "asset_name": "td_darwin_universal.tar.gz",
    },
}


class ReleaseError(ValueError):
    pass


def _github_headers():
    headers = {
        "Accept": "application/vnd.github+json",
        "User-Agent": "pixiv-swiftui-tap-sync",
    }
    github_token = os.environ.get("GITHUB_TOKEN")
    if github_token:
        headers["Authorization"] = f"Bearer {github_token}"
    return headers


def _github_get_json(url):
    request = urllib.request.Request(url, headers=_github_headers())
    with urllib.request.urlopen(request, timeout=REQUEST_TIMEOUT_SECONDS) as response:
        return json.load(response)


def select_release_for_app(releases, app):
    """从 release 列表中挑选第一个符合 app 要求的非草稿 release。"""
    pattern = app.get("tag_pattern")
    compiled = re.compile(pattern) if pattern else None
    if not isinstance(releases, list):
        raise ReleaseError("malformed releases list")
    for release in releases:
        if not isinstance(release, dict) or release.get("draft"):
            continue
        tag_name = release.get("tag_name")
        if not isinstance(tag_name, str) or not tag_name:
            continue
        if compiled is not None and not compiled.match(tag_name):
            continue
        return release
    raise ReleaseError("no matching release found")


def fetch_releases(app, per_page=100, max_pages=5):
    releases = []
    for page in range(1, max_pages + 1):
        url = (
            f"https://api.github.com/repos/{app['repo_slug']}/releases"
            f"?per_page={per_page}&page={page}"
        )
        batch = _github_get_json(url)
        if not isinstance(batch, list):
            raise ReleaseError("malformed releases list")
        releases.extend(batch)
        if len(batch) < per_page:
            break
    return releases


def fetch_latest_release(app):
    # 配置了 tag_pattern 的 app（如 fluidvoice）不能直接用 /releases/latest：
    # 该端点按发布时间取最新，上游一旦发布 Windows 专属 tag 就会误命中。
    # 改为拉取 release 列表并按 tag 正则挑选。
    if app.get("tag_pattern"):
        releases = fetch_releases(app)
        return select_release_for_app(releases, app)
    return _github_get_json(
        f"https://api.github.com/repos/{app['repo_slug']}/releases/latest"
    )


def normalize_version(tag_name):
    if not isinstance(tag_name, str) or not tag_name:
        raise ReleaseError("missing tag_name")
    return tag_name[1:] if tag_name.startswith("v") else tag_name


def extract_sha256(asset):
    digest = asset.get("digest")
    if not isinstance(digest, str) or not digest.startswith("sha256:"):
        raise ReleaseError(f"missing digest for {asset.get('name', 'unknown asset')}")

    value = digest.split(":", 1)[1]
    if len(value) != 64 or any(character not in "0123456789abcdef" for character in value.lower()):
        raise ReleaseError(f"malformed digest for {asset.get('name', 'unknown asset')}")
    return value


def find_asset(assets_by_name, app, arch, version=None):
    """Find an asset by exact name or suffix pattern."""
    if arch == "default" and "asset_name" in app:
        return assets_by_name.get(app["asset_name"])

    if arch == "default" and "asset_name_template" in app:
        if not isinstance(version, str) or not version:
            raise ReleaseError("missing version for asset_name_template")
        return assets_by_name.get(app["asset_name_template"].format(version=version))

    if "asset_names" in app and arch in app["asset_names"]:
        name = app["asset_names"][arch]
        return assets_by_name.get(name)

    if "asset_patterns" in app and arch in app["asset_patterns"]:
        suffix = app["asset_patterns"][arch]
        for name, asset in assets_by_name.items():
            if name.endswith(suffix):
                return asset

    return None


def release_targets(app):
    if "asset_name" in app or "asset_name_template" in app:
        return ["default"]

    return list(app.get("asset_names", app.get("asset_patterns", {})))


def extract_release_info(payload, app):
    if not isinstance(payload, dict):
        raise ReleaseError("malformed release payload")

    assets = payload.get("assets")
    if not isinstance(assets, list):
        raise ReleaseError("missing assets list")

    assets_by_name = {}
    for asset in assets:
        if isinstance(asset, dict) and isinstance(asset.get("name"), str):
            assets_by_name[asset["name"]] = asset

    version = normalize_version(payload.get("tag_name"))
    arches = release_targets(app)
    sha256 = {}
    for arch in arches:
        asset = find_asset(assets_by_name, app, arch, version=version)
        if asset is not None:
            sha256[arch] = extract_sha256(asset)

    return {
        "version": version,
        "sha256": sha256,
    }


def current_version(cask_text):
    for line in cask_text.splitlines():
        stripped = line.strip()
        if stripped.startswith("version ") and '"' in stripped:
            return stripped.split('"', 2)[1]
    raise ReleaseError("missing version in cask")


def replace_line(cask_text, prefix, new_line):
    lines = cask_text.splitlines()
    for index, line in enumerate(lines):
        if line.strip().startswith(prefix):
            lines[index] = new_line
            ending = "\n" if cask_text.endswith("\n") else ""
            return "\n".join(lines) + ending
    raise ReleaseError(f"missing {prefix} in cask")


def replace_sha256_lines(cask_text, release):
    if set(release["sha256"]) == {"default"}:
        return replace_line(cask_text, "sha256 ", f'  sha256 "{release["sha256"]["default"]}"')

    lines = cask_text.splitlines()
    for index, line in enumerate(lines):
        if line.strip().startswith("sha256 arm:"):
            if index + 1 >= len(lines) or not lines[index + 1].strip().startswith("intel:"):
                raise ReleaseError("missing intel sha256 in cask")

            lines[index] = f'  sha256 arm:   "{release["sha256"]["arm"]}",'
            lines[index + 1] = f'         intel: "{release["sha256"]["intel"]}"'
            ending = "\n" if cask_text.endswith("\n") else ""
            return "\n".join(lines) + ending
    raise ReleaseError("missing sha256 arm: in cask")


def update_cask_contents(cask_text, app, release):
    arches = release_targets(app)
    missing_arches = [arch for arch in arches if arch not in release["sha256"]]
    if missing_arches:
        raise ReleaseError(f"missing assets for: {', '.join(missing_arches)}")

    updated_text = replace_line(cask_text, "version ", f'  version "{release["version"]}"')
    return replace_sha256_lines(updated_text, release)


def sync_app(app_name, cask_override=None, fetch_release=fetch_latest_release, dry_run=False):
    app = APPS[app_name]
    cask_path = pathlib.Path(cask_override) if cask_override else app["cask_path"]

    try:
        payload = fetch_release(app)
        release = extract_release_info(payload, app)
    except urllib.error.HTTPError as exc:
        exc.close()
        if exc.code == 404 and app_name in ("openkara", "apple-say", "sukiru"):
            print(f"Skipping {app_name}: no published release found")
            return 0
        print(f"Error: {exc}", file=sys.stderr)
        return 1
    except urllib.error.URLError as exc:
        # HTTPError 已在上面处理；这里接 DNS / 连接 / TLS 等纯网络失败，
        # 同样记为单 app 失败并返回 1，让 main() 继续跑后面的 app。
        print(f"Error: {exc}", file=sys.stderr)
        return 1
    except (ValueError, json.JSONDecodeError) as exc:
        print(f"Error: {exc}", file=sys.stderr)
        return 1

    try:
        cask_text = cask_path.read_text(encoding="utf-8")
        installed_version = current_version(cask_text)
        updated_text = update_cask_contents(cask_text, app, release)
        if updated_text == cask_text:
            print(f"Already up to date at {installed_version}")
            return 0
    except (OSError, ValueError, json.JSONDecodeError) as exc:
        print(f"Error: {exc}", file=sys.stderr)
        return 1

    if dry_run:
        print(f"Would update {cask_path} from {installed_version} to {release['version']}")
        return 0

    cask_path.write_text(updated_text, encoding="utf-8")
    print(f"Updated {cask_path} from {installed_version} to {release['version']}")
    return 0


def main(argv=None, fetch_release=fetch_latest_release):
    parser = argparse.ArgumentParser()
    parser.add_argument("--app", choices=sorted(APPS), action="append")
    parser.add_argument("--dry-run", action="store_true")
    parser.add_argument("--cask")
    args = parser.parse_args(argv)

    apps = args.app or ["pixiv-swiftui"]

    if args.cask and len(apps) > 1:
        # 同一个 --cask 覆盖文件会被逐个 app 复用：第一个 app 失败后继续跑
        # 第二个 app 时，会把第二个 app 的版本写进第一个 app 的文件。
        # 多 app 时直接拒绝，保持单 app 覆盖行为不变。
        parser.error("--cask 不能和多个 --app 合用：覆盖文件会被每个 app 复用")

    failed_apps = []
    for app_name in apps:
        exit_code = sync_app(
            app_name,
            cask_override=args.cask,
            fetch_release=fetch_release,
            dry_run=args.dry_run,
        )
        if exit_code != 0:
            # 单个 app 失败只记录并继续，避免一个 app 挂掉整单
            # （如 fluidvoice 曾因上游 Windows tag 导致整单全挂）。
            print(f"Failed {app_name}", file=sys.stderr)
            failed_apps.append(app_name)

    if failed_apps:
        print(f"Failed apps: {', '.join(failed_apps)}", file=sys.stderr)
        return 1

    return 0


if __name__ == "__main__":
    raise SystemExit(main())

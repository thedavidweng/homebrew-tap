#!/usr/bin/env python3

import argparse
import json
import os
import pathlib
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
}


class ReleaseError(ValueError):
    pass


def fetch_latest_release(app):
    headers = {
        "Accept": "application/vnd.github+json",
        "User-Agent": "pixiv-swiftui-tap-sync",
    }
    github_token = os.environ.get("GITHUB_TOKEN")
    if github_token:
        headers["Authorization"] = f"Bearer {github_token}"

    request = urllib.request.Request(
        f"https://api.github.com/repos/{app['repo_slug']}/releases/latest",
        headers=headers,
    )
    with urllib.request.urlopen(request, timeout=REQUEST_TIMEOUT_SECONDS) as response:
        return json.load(response)


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


def find_asset(assets_by_name, app, arch):
    """Find an asset by exact name or suffix pattern."""
    if "asset_names" in app and arch in app["asset_names"]:
        name = app["asset_names"][arch]
        return assets_by_name.get(name)

    if "asset_patterns" in app and arch in app["asset_patterns"]:
        suffix = app["asset_patterns"][arch]
        for name, asset in assets_by_name.items():
            if name.endswith(suffix):
                return asset

    return None


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

    arches = app.get("asset_names", app.get("asset_patterns", {}))
    sha256 = {}
    for arch in arches:
        asset = find_asset(assets_by_name, app, arch)
        if asset is not None:
            sha256[arch] = extract_sha256(asset)

    return {
        "version": normalize_version(payload.get("tag_name")),
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
    arches = app.get("asset_names", app.get("asset_patterns", {}))
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
        if exc.code == 404 and app_name == "openkara":
            print(f"Skipping {app_name}: no published release found")
            return 0
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

    for app_name in apps:
        exit_code = sync_app(
            app_name,
            cask_override=args.cask,
            fetch_release=fetch_release,
            dry_run=args.dry_run,
        )
        if exit_code != 0:
            return exit_code

    return 0


if __name__ == "__main__":
    raise SystemExit(main())

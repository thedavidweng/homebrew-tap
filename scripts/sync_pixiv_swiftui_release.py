#!/usr/bin/env python3

import argparse
import json
import os
import pathlib
import sys
import urllib.request


API_URL = "https://api.github.com/repos/Eslzzyl/Pixiv-SwiftUI/releases/latest"
DEFAULT_CASK_PATH = pathlib.Path(__file__).resolve().parents[1] / "Casks" / "pixiv-swiftui.rb"
ASSET_NAMES = {
    "arm": "Pixiv-SwiftUI-arm64.dmg",
    "intel": "Pixiv-SwiftUI-x86_64.dmg",
}


class ReleaseError(ValueError):
    pass


def fetch_latest_release():
    headers = {
        "Accept": "application/vnd.github+json",
        "User-Agent": "pixiv-swiftui-tap-sync",
    }
    github_token = os.environ.get("GITHUB_TOKEN")
    if github_token:
        headers["Authorization"] = f"Bearer {github_token}"

    request = urllib.request.Request(
        API_URL,
        headers=headers,
    )
    with urllib.request.urlopen(request) as response:
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


def extract_release_info(payload):
    if not isinstance(payload, dict):
        raise ReleaseError("malformed release payload")

    assets = payload.get("assets")
    if not isinstance(assets, list):
        raise ReleaseError("missing assets list")

    assets_by_name = {}
    for asset in assets:
        if isinstance(asset, dict) and isinstance(asset.get("name"), str):
            assets_by_name[asset["name"]] = asset

    return {
        "version": normalize_version(payload.get("tag_name")),
        "sha256": {
            arch: extract_sha256(assets_by_name[name])
            for arch, name in ASSET_NAMES.items()
            if name in assets_by_name
        },
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


def update_cask_contents(cask_text, release):
    missing_arches = [arch for arch in ASSET_NAMES if arch not in release["sha256"]]
    if missing_arches:
        raise ReleaseError(f"missing assets for: {', '.join(missing_arches)}")

    updated_text = replace_line(cask_text, "version ", f'  version "{release["version"]}"')
    updated_text = replace_line(
        updated_text,
        "sha256 arm:",
        f'  sha256 arm:   "{release["sha256"]["arm"]}",',
    )
    return replace_line(
        updated_text,
        "intel:",
        f'         intel: "{release["sha256"]["intel"]}"',
    )


def main(argv=None, fetch_release=fetch_latest_release):
    parser = argparse.ArgumentParser()
    parser.add_argument("--dry-run", action="store_true")
    parser.add_argument("--cask", default=str(DEFAULT_CASK_PATH))
    args = parser.parse_args(argv)

    cask_path = pathlib.Path(args.cask)

    try:
        payload = fetch_release()
        release = extract_release_info(payload)
        cask_text = cask_path.read_text(encoding="utf-8")
        installed_version = current_version(cask_text)
        updated_text = update_cask_contents(cask_text, release)
        if updated_text == cask_text:
            print(f"Already up to date at {installed_version}")
            return 0
    except (OSError, ValueError, json.JSONDecodeError) as exc:
        print(f"Error: {exc}", file=sys.stderr)
        return 1

    if args.dry_run:
        print(f"Would update {cask_path} from {installed_version} to {release['version']}")
        return 0

    cask_path.write_text(updated_text, encoding="utf-8")
    print(f"Updated {cask_path} from {installed_version} to {release['version']}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

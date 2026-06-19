# homebrew-tap

Homebrew tap for my own apps and CLI tools, plus a curated set of third-party apps I help distribute.

## Install

```bash
brew tap thedavidweng/homebrew-tap
```

## My Apps

| App | Description | Type |
|-----|-------------|------|
| [OpenKara](https://github.com/thedavidweng/OpenKara) | Open source karaoke player for macOS | cask |
| [OpenLoop](https://github.com/thedavidweng/OpenLoop) | AI music generation desktop application | cask |

```bash
brew install --cask thedavidweng/tap/openkara
brew install --cask thedavidweng/tap/openloop
```

## My CLI Tools

| Tool | Description | Type |
|------|-------------|------|
| [Money](https://github.com/thedavidweng/money) | Local-first personal finance backend | cask |
| [Canvas CLI](https://github.com/thedavidweng/canvas-cli) | Agent-friendly CLI for Canvas LMS | cask |
| [Monarch Money CLI](https://github.com/thedavidweng/monarchmoney-cli) | CLI for Monarch Money | cask |
| [Zenodo CLI](https://github.com/thedavidweng/zenodo-cli) | CLI for Zenodo deposit management | cask |
| [Flickr CLI](https://github.com/thedavidweng/flickr-cli) | CLI for Flickr photo management | cask |

```bash
brew install --cask thedavidweng/tap/money
brew install --cask thedavidweng/tap/canvas
brew install --cask thedavidweng/tap/monarchmoney-cli
brew install --cask thedavidweng/tap/zenodo
brew install --cask thedavidweng/tap/flickr
```

## Third-Party Apps

| App | Description | Type |
|-----|-------------|------|
| [Screenize](https://github.com/syi0808/screenize) | Screen recording editor for macOS | cask |
| [Pixiv-SwiftUI](https://github.com/Eslzzyl/Pixiv-SwiftUI) | SwiftUI-based Pixiv client | cask |
| [FluidVoice](https://github.com/altic-dev/FluidVoice) | Voice synthesis application | cask |
| [WiiUDownloader](https://github.com/Xpl0itU/WiiUDownloader) | Download Wii U games from Nintendo's servers | cask |
| [NotchPrompt](https://github.com/saif0200/notchprompt) | Menu bar teleprompter | cask |
| [i4Tools](https://www.i4.cn/) | iOS device management tool | cask |

```bash
brew install --cask thedavidweng/tap/screenize
brew install --cask thedavidweng/tap/pixiv-swiftui
brew install --cask thedavidweng/tap/fluidvoice
brew install --cask thedavidweng/tap/wiiu-downloader
brew install --cask thedavidweng/tap/notchprompt
brew install --cask thedavidweng/tap/i4tools
```

## Upgrade

```bash
brew update && brew upgrade --cask <cask>
```

## Local Development

```bash
brew audit --cask --strict --tap thedavidweng/homebrew-tap <cask>
```

## How Updates Work

- **My apps** (`OpenKara`, `OpenLoop`): updated directly in this repo.
- **GoReleaser-managed** (`Money`, `Canvas CLI`, `Monarch Money CLI`, `Zenodo CLI`, `Flickr CLI`): published from their own repos via GoReleaser; casks are updated by the release workflow in those repos.
- **Third-party apps** (`Screenize`, `Pixiv-SwiftUI`, `FluidVoice`, `WiiUDownloader`, `NotchPrompt`): synced automatically from their latest GitHub releases via a scheduled workflow in this repo.
- **i4Tools**: versioned with a livecheck that follows the redirect URL to detect new releases automatically. Updated via `brew bump-cask-pr` when `brew livecheck` reports a new version.

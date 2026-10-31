# homebrew-tap

Homebrew tap for my own apps and CLI tools, plus a curated set of third-party apps I help distribute.

## Install

```bash
brew tap thedavidweng/homebrew-tap
brew trust thedavidweng/tap
```

## My Apps

| App | Description | Type |
|-----|-------------|------|
| [Apple Say](https://github.com/thedavidweng/apple-say) | Native macOS text-to-speech editor and audio exporter | cask |
| [OpenKara](https://github.com/thedavidweng/OpenKara) | Open source karaoke player for macOS | cask |
| [OpenLoop](https://github.com/thedavidweng/OpenLoop) | AI music generation desktop application | cask |
| [SDF Flash GUI](https://github.com/thedavidweng/sdf-flash-gui) | Optical drive firmware utility | cask |
| [Sukiru](https://github.com/thedavidweng/sukiru) | Native macOS skill-library health checker and repairer | cask |
| [Vapourfly](https://github.com/thedavidweng/vapourfly) | Local-first Steam library manager and playlist organizer | cask |

```bash
brew install --cask thedavidweng/tap/apple-say
brew install --cask thedavidweng/tap/openkara
brew install --cask thedavidweng/tap/openloop
brew install --cask thedavidweng/tap/sdf-flash-gui
brew install --cask thedavidweng/tap/sukiru
brew install --cask thedavidweng/tap/vapourfly
```

## My CLI Tools

| Tool | Description | Type |
|------|-------------|------|
| [Money](https://github.com/thedavidweng/money) | Local-first personal finance backend | cask |
| [Canvas CLI](https://github.com/thedavidweng/canvas-cli) | Agent-friendly CLI for Canvas LMS | cask |
| [Jobs CLI](https://github.com/thedavidweng/jobs-cli) | Agent-friendly CLI for job discovery and applications | cask; formula (HEAD) |
| [Monarch Money CLI](https://github.com/thedavidweng/monarchmoney-cli) | CLI for Monarch Money | cask |
| [Zenodo CLI](https://github.com/thedavidweng/zenodo-cli) | CLI for Zenodo deposit management | formula |
| [Amazon Photos CLI](https://github.com/thedavidweng/amazon-photos) | Unofficial Amazon Photos CLI and Go SDK | formula |
| [Qualtrics CLI](https://github.com/thedavidweng/qualtrics-cli) | CLI for the Qualtrics survey platform | cask |
| [Flickr CLI](https://github.com/thedavidweng/flickr-cli) | CLI for Flickr photo management | cask |
| [Strudel TUI](https://github.com/thedavidweng/strudel-tui) | Terminal live coding for Strudel with an AI agent | cask |
| [tg-drive](https://github.com/thedavidweng/tg-drive) | Telegram-backed virtual file tree CLI (`td`) | cask |

```bash
brew install --cask thedavidweng/tap/money
brew install --cask thedavidweng/tap/canvas
brew install --cask thedavidweng/tap/jobs-cli
brew install --cask thedavidweng/tap/monarchmoney-cli
brew install --formula thedavidweng/tap/zenodo
brew install --formula thedavidweng/tap/aphotos
brew install --cask thedavidweng/tap/qualtrics
brew install --cask thedavidweng/tap/flickr
brew install --cask thedavidweng/tap/strudel-tui
brew install --cask thedavidweng/tap/tg-drive
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
| [Telegram Drive](https://github.com/caamer20/Telegram-Drive) | Telegram-backed file manager | cask |

```bash
brew install --cask thedavidweng/tap/screenize
brew install --cask thedavidweng/tap/pixiv-swiftui
brew install --cask thedavidweng/tap/fluidvoice
brew install --cask thedavidweng/tap/wiiu-downloader
brew install --cask thedavidweng/tap/notchprompt
brew install --cask thedavidweng/tap/i4tools
brew install --cask thedavidweng/tap/telegram-drive
```

## Upgrade

```bash
brew update && brew upgrade --cask <cask>
```

## Local Development

```bash
brew audit --cask --strict thedavidweng/tap/<cask>
```

## How Updates Work

Homebrew checks all casks for new upstream releases every three hours and opens
a pull request for each update. Passing updates merge automatically after the
cask audit, style check and other pull request checks complete. A failed check
leaves the pull request open for review. The formulae for Amazon Photos and
Zenodo are still published by their respective release workflows.

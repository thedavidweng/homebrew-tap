# homebrew-tap

Homebrew tap for my own apps, plus a small set of additional third-party apps I help distribute.

## Apps

### My own apps

- `OpenKara`
- `OpenLoop`
- `Money`
- `Monarch Money CLI`
- `Flickr CLI`

### Additional third-party apps

- `Screenize`
- `Pixiv-SwiftUI`
- `FluidVoice`
- `WiiUDownloader`
- `i4Tools`

## Install

```bash
brew tap thedavidweng/homebrew-tap
```

### OpenKara

```bash
brew install --cask thedavidweng/tap/openkara
```

### OpenLoop

```bash
brew install --cask thedavidweng/tap/openloop
```

### Money

```bash
brew install --cask thedavidweng/tap/money
```

If you installed the old formula:

```bash
brew update
brew uninstall --formula thedavidweng/tap/money
brew install --cask thedavidweng/tap/money
money version
```

### Monarch Money CLI

```bash
brew install --cask thedavidweng/tap/monarchmoney-cli
```

If you installed the old formula:

```bash
brew update
brew uninstall --formula thedavidweng/tap/monarchmoney-cli
brew install --cask thedavidweng/tap/monarchmoney-cli
monarch version
```

### Flickr CLI

```bash
brew install --formula thedavidweng/tap/flickr
```

### Screenize

```bash
brew install --cask thedavidweng/tap/screenize
```

### Pixiv-SwiftUI

```bash
brew install --cask thedavidweng/tap/pixiv-swiftui
```

### FluidVoice

```bash
brew install --cask thedavidweng/tap/fluidvoice
```

### WiiUDownloader

```bash
brew install --cask thedavidweng/tap/wiiu-downloader
```

### i4Tools

```bash
brew install --cask thedavidweng/tap/i4tools
```

## Upgrade

### OpenKara

```bash
brew update
brew upgrade --cask openkara
```

### OpenLoop

```bash
brew update
brew upgrade --cask openloop
```

### Money

```bash
brew update
brew upgrade --cask money
```

### Monarch Money CLI

```bash
brew update
brew upgrade --cask monarchmoney-cli
```

### Flickr CLI

```bash
brew update
brew upgrade flickr
```

### Screenize

```bash
brew update
brew upgrade --cask screenize
```

### Pixiv-SwiftUI

```bash
brew update
brew upgrade --cask pixiv-swiftui
```

### FluidVoice

```bash
brew update
brew upgrade --cask fluidvoice
```

### WiiUDownloader

```bash
brew update
brew upgrade --cask wiiu-downloader
```

### i4Tools

```bash
brew update
brew upgrade --cask i4tools
```

## Local Development

```bash
brew audit --strict --tap thedavidweng/homebrew-tap flickr
brew audit --cask --strict --tap thedavidweng/homebrew-tap openkara
brew audit --cask --strict --tap thedavidweng/homebrew-tap screenize
brew audit --cask --strict --tap thedavidweng/homebrew-tap pixiv-swiftui
brew audit --cask --strict --tap thedavidweng/homebrew-tap fluidvoice
brew audit --cask --strict --tap thedavidweng/homebrew-tap openloop
brew audit --cask --strict --tap thedavidweng/homebrew-tap money
brew audit --cask --strict --tap thedavidweng/homebrew-tap monarchmoney-cli
brew audit --cask --strict --tap thedavidweng/homebrew-tap wiiu-downloader
brew audit --cask --strict --tap thedavidweng/homebrew-tap i4tools
```

If the app is blocked on first launch, remove quarantine manually:

```bash
xattr -rd com.apple.quarantine /Applications/Pixiv-SwiftUI.app
```

## Updating The Cask

Each cask in this tap can be maintained independently.

This tap includes a scheduled sync workflow that checks upstream releases for all apps and updates the matching files in `Casks/` when needed. `OpenKara` and `OpenLoop` are my own apps in this tap. `Screenize`, `Pixiv-SwiftUI`, `FluidVoice`, `WiiUDownloader`, and `i4Tools` are additional third-party apps synced the same way directly from their latest GitHub releases, without requiring any changes from their maintainers. You can also run the workflow manually from the GitHub Actions page.

`Money`, `Monarch Money CLI`, and `Flickr CLI` are published from their own repositories via GoReleaser, so their formulas/casks are updated by the release workflow in those repos instead of this tap's sync job.

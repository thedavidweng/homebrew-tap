# homebrew-tap

Homebrew tap for macOS apps and tools I maintain or help distribute.

The tap currently includes `Pixiv-SwiftUI` plus prewired `OpenKara` support. `OpenKara` install and upgrade become usable after its first upstream release exists.

## Install

### Pixiv-SwiftUI

```bash
brew tap thedavidweng/homebrew-tap
brew install --cask pixiv-swiftui
```

### OpenKara

Available after the first upstream release:

```bash
brew tap thedavidweng/homebrew-tap
brew install --cask openkara
```

## Upgrade

### Pixiv-SwiftUI

```bash
brew update
brew upgrade --cask pixiv-swiftui
```

### OpenKara

Available after the first upstream release:

```bash
brew update
brew upgrade --cask openkara
```

## Local Development

```bash
brew audit --cask --strict --tap thedavidweng/homebrew-tap pixiv-swiftui
brew audit --cask --strict --tap thedavidweng/homebrew-tap openkara
```

If the app is blocked on first launch, remove quarantine manually:

```bash
xattr -rd com.apple.quarantine /Applications/Pixiv-SwiftUI.app
```

## Updating The Cask

Each cask in this tap can be maintained independently.

This tap includes a scheduled sync workflow that checks upstream releases for `Pixiv-SwiftUI` and `OpenKara`, then updates the matching files in `Casks/` when needed. If `OpenKara` has not published its first release yet, it is skipped automatically and will start syncing once releases exist. You can also run the workflow manually from the GitHub Actions page.

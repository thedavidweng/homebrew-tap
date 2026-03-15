# homebrew-tap

Homebrew tap for macOS apps and tools I maintain or help distribute.

The tap can host multiple casks over time. `Pixiv-SwiftUI` is the first one currently available.

## Install

### Pixiv-SwiftUI

```bash
brew tap thedavidweng/homebrew-tap
brew install --cask pixiv-swiftui
```

## Upgrade

### Pixiv-SwiftUI

```bash
brew update
brew upgrade --cask pixiv-swiftui
```

## Local Development

```bash
brew audit --cask --strict Casks/pixiv-swiftui.rb
```

If the app is blocked on first launch, remove quarantine manually:

```bash
xattr -rd com.apple.quarantine /Applications/Pixiv-SwiftUI.app
```

## Updating The Cask

Each cask in this tap can be maintained independently.

For `Pixiv-SwiftUI`, the main repository contains release automation that updates `Casks/pixiv-swiftui.rb` after a tagged release. If you need to refresh it manually, update the version and both SHA256 values to match the latest GitHub release DMGs.

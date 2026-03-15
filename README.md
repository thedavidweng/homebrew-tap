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
brew audit --cask --strict --tap thedavidweng/homebrew-tap pixiv-swiftui
```

If the app is blocked on first launch, remove quarantine manually:

```bash
xattr -rd com.apple.quarantine /Applications/Pixiv-SwiftUI.app
```

## Updating The Cask

Each cask in this tap can be maintained independently.

For `Pixiv-SwiftUI`, this tap includes its own scheduled sync workflow that checks the latest upstream release and updates `Casks/pixiv-swiftui.rb` when needed. You can also run the workflow manually from the GitHub Actions page.

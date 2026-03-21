# homebrew-tap

Homebrew tap for my own macOS app, plus a small set of additional third-party apps I help distribute.

## Apps

### My own app

- `OpenKara`

### Additional third-party apps

- `Screenize`
- `Pixiv-SwiftUI`

## Install

### OpenKara

```bash
brew tap thedavidweng/homebrew-tap
brew install --cask openkara
```

### Screenize

```bash
brew tap thedavidweng/homebrew-tap
brew install --cask screenize
```

### Pixiv-SwiftUI

```bash
brew tap thedavidweng/homebrew-tap
brew install --cask pixiv-swiftui
```

## Upgrade

### OpenKara

```bash
brew update
brew upgrade --cask openkara
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

## Local Development

```bash
brew audit --cask --strict --tap thedavidweng/homebrew-tap openkara
brew audit --cask --strict --tap thedavidweng/homebrew-tap screenize
brew audit --cask --strict --tap thedavidweng/homebrew-tap pixiv-swiftui
```

If the app is blocked on first launch, remove quarantine manually:

```bash
xattr -rd com.apple.quarantine /Applications/Pixiv-SwiftUI.app
```

## Updating The Cask

Each cask in this tap can be maintained independently.

This tap includes a scheduled sync workflow that checks upstream releases for all three apps and updates the matching files in `Casks/` when needed. `OpenKara` is my own app in this tap. `Screenize` and `Pixiv-SwiftUI` are additional third-party apps synced the same way directly from their latest GitHub releases, without requiring any changes from their maintainers. You can also run the workflow manually from the GitHub Actions page.

cask "pixiv-swiftui" do
  arch arm: "arm64", intel: "x86_64"

  version "0.16.2"
  sha256 arm:   "5b1fc9176e95eda50a0f96f7f29b13f1276e15068d6d1b5bbecab34b1614475c",
         intel: "64b37447f06115aa858149647b668739c843be04089854d78688904d39a2dc00"

  url "https://github.com/Eslzzyl/Pixiv-SwiftUI/releases/download/v#{version}/Pixiv-SwiftUI-#{arch}.dmg"
  name "Pixiv-SwiftUI"
  desc "SwiftUI-based Pixiv third-party client"
  homepage "https://github.com/Eslzzyl/Pixiv-SwiftUI"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Pixiv-SwiftUI.app"

  caveats do
    <<~EOS
      This app is currently distributed without Apple notarization.
      If macOS blocks launch after installation, remove quarantine with:
        xattr -rd com.apple.quarantine /Applications/Pixiv-SwiftUI.app
    EOS
  end
end

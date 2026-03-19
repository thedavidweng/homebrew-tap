cask "pixiv-swiftui" do
  arch arm: "arm64", intel: "x86_64"

  version "0.12.1"
  sha256 arm:   "8c6c65ffb2417e4c38ba3075e6007ec7f9da29953a3006a0ce9d54d522b88b2e",
         intel: "7fc14da559746a2d8ba08277cf2aa2b8f00239e9e5b2ac0e21518cf0af6b8c0b"

  url "https://github.com/Eslzzyl/Pixiv-SwiftUI/releases/download/v#{version}/Pixiv-SwiftUI-#{arch}.dmg"
  name "Pixiv-SwiftUI"
  desc "SwiftUI-based Pixiv third-party client"
  homepage "https://github.com/Eslzzyl/Pixiv-SwiftUI"

  depends_on macos: ">= :sonoma"

  app "Pixiv-SwiftUI.app"

  livecheck do
    url :url
    strategy :github_latest
  end

  caveats do
    <<~EOS
      This app is currently distributed without Apple notarization.
      If macOS blocks launch after installation, remove quarantine with:
        xattr -rd com.apple.quarantine /Applications/Pixiv-SwiftUI.app
    EOS
  end
end

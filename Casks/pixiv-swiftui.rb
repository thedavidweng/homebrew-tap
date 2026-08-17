cask "pixiv-swiftui" do
  arch arm: "arm64", intel: "x86_64"

  version "0.15.0"
  sha256 arm:   "7f97160d5f84bc2ae0fdc2908488e9fd3d62484275f45d94915b60c8fda8bff0",
         intel: "1386fb41e069aa642472309e75b90ab9a2cfa926d16e9ebbeeed8c7378580be0"

  url "https://github.com/Eslzzyl/Pixiv-SwiftUI/releases/download/v#{version}/Pixiv-SwiftUI-#{arch}.dmg"
  name "Pixiv-SwiftUI"
  desc "SwiftUI-based Pixiv third-party client"
  homepage "https://github.com/Eslzzyl/Pixiv-SwiftUI"

  depends_on macos: :sonoma

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

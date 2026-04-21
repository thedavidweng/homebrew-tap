cask "pixiv-swiftui" do
  arch arm: "arm64", intel: "x86_64"

  version "0.13.0"
  sha256 arm:   "7922178a22a40f93758c6fd53ad99d0c5890807d49537552c543616b4d81f98c",
         intel: "65796699b43141c8551b54c9e36aaa9af3b97263a7d4efc3506897d98f5efb4a"

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

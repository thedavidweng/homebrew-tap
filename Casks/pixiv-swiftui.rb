cask "pixiv-swiftui" do
  arch arm: "arm64", intel: "x86_64"

  version "0.14.1"
  sha256 arm:   "0399da2496d0b3105cba21e3d406faed3fc85ec45b327eca3e2d315707804454",
         intel: "bf778934de17c0c0dfaa609a0d718c8a9f9160cd8d7c4ae2b5ee18e57aefd03d"

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

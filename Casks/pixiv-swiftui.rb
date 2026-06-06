cask "pixiv-swiftui" do
  arch arm: "arm64", intel: "x86_64"

  version "0.14.3"
  sha256 arm:   "3a336614129c059de325d3f29091c15343b8c3eb20a528796a4ed241f5ef71bb",
         intel: "4c87beda46e9201cec6d7f3650eb1bfee68ad8f7efec424edfa37699fcf5d8bb"

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

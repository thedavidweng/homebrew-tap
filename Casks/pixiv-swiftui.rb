cask "pixiv-swiftui" do
  arch arm: "arm64", intel: "x86_64"

  version "0.14.4"
  sha256 arm:   "b42fe4e6e8b40a99abb0afefe0a39710dd9575d3f070d76f1871c9b5cb59a523",
         intel: "2293bdd37d753f43148a756a8e5cc8adbdde0eafa1211ee472eb6e0b6473117e"

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

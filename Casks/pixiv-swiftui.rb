cask "pixiv-swiftui" do
  arch arm: "arm64", intel: "x86_64"

  version "0.14.0"
  sha256 arm:   "e52270d846bc26c5f6f005e44ff81bc00c4312023b9632ad782f95bb9d985f33",
         intel: "8b506f125d6f6ac114fe6e6af6c7faa946c015d20b078e6b57f59e8e8413eee5"

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

cask "pixiv-swiftui" do
  arch arm: "arm64", intel: "x86_64"

  version "0.12.0"
  sha256 arm:   "dec13cc7c95a3eafff0408d8ca0161816ab936c963e305f4ac058ce1c10178a9",
         intel: "5a0f724db30141bd5deeb41c535890ec87d340994e35ad5443e28214413dc1ad"

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

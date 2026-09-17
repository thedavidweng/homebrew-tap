cask "pixiv-swiftui" do
  arch arm: "arm64", intel: "x86_64"

  version "0.16.0"
  sha256 arm:   "82b5619d07b63cf5e2af9c9825f3b5a646bd18918224d4bb9c099befa35bcd46",
         intel: "10142f7aea16588e74cb8cd9ecff6dc2a11b481dc3cce099371240f03e1036f7"

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

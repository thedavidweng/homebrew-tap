cask "pixiv-swiftui" do
  arch arm: "arm64", intel: "x86_64"

  version "0.14.2"
  sha256 arm:   "3f27401f93f5da73c097d918cc4fc632fad6a7e1a7686bb6777258b251ca23b0",
         intel: "686c552bf905ef59d3cd97fe2c2e9b3cf11bbc89ae984d92843b3f1514dd078d"

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

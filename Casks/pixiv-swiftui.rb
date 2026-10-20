cask "pixiv-swiftui" do
  arch arm: "arm64", intel: "x86_64"

  version "0.16.3"
  sha256 arm:   "f4a70425168fd28456373f4619eb209ee1c8e3c43798b728aa453ecdc7f93511",
         intel: "386f45e85f3ffb7b5d9688e672585d28aafb3ea39ee6315303da5217d29f6f4c"

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

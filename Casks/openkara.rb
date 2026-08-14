cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.14.0"
  sha256 arm:   "0dd425af9af6cb5feb90ea2643f4a70b6708e3e0502ccb078de2e08c4164edf4",
         intel: "51f6e95cea660d9d99d7e1479e60fc567a69f2d53eea55812e924e8664e92a08"

  url "https://github.com/thedavidweng/OpenKara/releases/download/v#{version}/OpenKara_#{version}_#{arch}.dmg"
  name "OpenKara"
  desc "Open source karaoke player for macOS"
  homepage "https://github.com/thedavidweng/OpenKara"

  app "OpenKara.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-rd", "com.apple.quarantine", "#{appdir}/OpenKara.app"]
  end

  livecheck do
    url :url
    strategy :github_latest
  end
end

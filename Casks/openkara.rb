cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.13.2"
  sha256 arm:   "9e0e1602facf69fa54f6dc538433474d384c1831a11dcc88ae74e4a2aa541f6f",
         intel: "84fc696da0231d975b2c9be81700a677c2ab05e4fef49ffcad63d006b8b26495"

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

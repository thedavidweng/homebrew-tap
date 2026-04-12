cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.5.0"
  sha256 arm:   "ce4de46d56c2c560daaa375f60c607304631e896b592184bc0a82da617de129e",
         intel: "c819478cbe7d8154b501eeacb9653af8697d195fc6fcf44814e5dc9945ffaee4"

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

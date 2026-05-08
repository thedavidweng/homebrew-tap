cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.8.0"
  sha256 arm:   "dab67e75d9a80a0d2b21e19a41831387bb1ad73ee8605f7f76bddd553f10c439",
         intel: "e3d24eca701cbc5196b1cc1d4027572db40712903166df328d0ae9735ec39b01"

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

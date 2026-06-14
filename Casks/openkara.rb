cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.9.0"
  sha256 arm:   "c566e44d195bde7740d829f2db7b454c42c2d575d41f57192343d75d7c71e6b0",
         intel: "0b5b56c02d8056097af6d8b3b3016d552652f8392d0d7a094cc344ccea22ed34"

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

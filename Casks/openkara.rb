cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.6.0"
  sha256 arm:   "c30a5da78ad3cecd6470623881e896e2334cd50ffe8649dfe11558d6b8618a9d",
         intel: "a9113fd0be475f647146726a132320881bce9f4f188dad3a2866fd5d2016fb8d"

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

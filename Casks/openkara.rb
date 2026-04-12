cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.5.0"
  sha256 arm:   "d794e9327a49e59e166009e37f541bff8bd971ef16254c53348914967b2ba1f3",
         intel: "ac834569fac6da51236dcbf8a326fbdeb22f772ec73ca06b805a8e8d4befafdd"

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

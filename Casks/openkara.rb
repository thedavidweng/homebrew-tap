cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.6.0"
  sha256 arm:   "1ee781c6dd585c667d3b34fb55c3036dea58efd776bc9eb992bbb1c11e11a615",
         intel: "3ee9b4e75383704321e9c37f809a6fd020657d3397244d671bff30f0c237a891"

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

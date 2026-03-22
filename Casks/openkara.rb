cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.3.0"
  sha256 arm:   "0e77d7ad566db736263169cccc140b9d8d4cd7bf06f6d07055c2bd4a7e8e9b78",
         intel: "0a61fdfa053d485034b9eec3a655a281994563b71bdc5a684681068d75111ff2"

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

cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.16.0"
  sha256 arm:   "d5d1256572bd95474e99d74c9b48bb405445f1479dc29e456c03309640f614ed",
         intel: "59149adc125f506d5f17fca8ced5787b21406dce18f955d4951fd444aa38ca91"

  url "https://github.com/thedavidweng/OpenKara/releases/download/v#{version}/OpenKara_#{version}_#{arch}.dmg"
  name "OpenKara"
  desc "Open-source karaoke player"
  homepage "https://github.com/thedavidweng/OpenKara"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "OpenKara.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-rd", "com.apple.quarantine", "{{appdir}}/OpenKara.app"]
  end
end

cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.19.0"
  sha256 arm:   "49da95d6570fd0ccdda01cee06eeecf3473a380153e3439366259202cc8c056e",
         intel: "62280aac47c855cf58963561130ecc1c2cb0bd1b03633f9243bb4741c60bb6dc"

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
end

cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.1.0"
  sha256 arm:   "49aab6d01fac1b6022217d6fdadee096e178502572b2e506da4f5a24510fcc3e",
         intel: "53c5c582521e434763ad7ce36fc5b859af4c7b9a0d27525ee120d9d5ec783964"

  url "https://github.com/thedavidweng/OpenKara/releases/download/v#{version}/OpenKara_#{version}_#{arch}.dmg"
  name "OpenKara"
  desc "Open source karaoke player for macOS"
  homepage "https://github.com/thedavidweng/OpenKara"

  app "OpenKara.app"

  livecheck do
    url :url
    strategy :github_latest
  end
end

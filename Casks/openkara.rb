cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.18.1"
  sha256 arm:   "160857d2d9f9bdb7fa6fa40679cd34c49eb11745214b159d862ed4797b231a27",
         intel: "7616c0f7c249ffe552fce7a773dd602ff1176f4eca1f44510c2dadc2d5ddbeb1"

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

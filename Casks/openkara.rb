cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.18.0"
  sha256 arm:   "4533d64a2aaa1c4a7d47f9598d1d009f97ebf9d58ed54b4d38f81528c0522e1c",
         intel: "1155b4f7945386c0638602ff932a6feefb681d63772745a48ee97b169b2cdcf1"

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

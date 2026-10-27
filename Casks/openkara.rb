cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.18.2"
  sha256 arm:   "70e35440748a78acea2b94e6cb9e54dcb87136589d3333e3fea3c28f4145f9a5",
         intel: "2cf0b71756a30f239e320cbbac501b7edc7c53c8f61441671e07a77b92051834"

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

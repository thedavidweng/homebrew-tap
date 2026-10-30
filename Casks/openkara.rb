cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.19.2"
  sha256 arm:   "09d85ef8fe9717dae57983c7bf5a847385b9da4353046d46fc769fdac4cb41c4",
         intel: "7e960ef6a3e4d61e6c6d1f36f7f1a6f2d64f8edce1b99494851cdd4649b34ed9"

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

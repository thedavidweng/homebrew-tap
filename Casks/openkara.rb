cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.16.2"
  sha256 arm:   "e07edc01610b4bbfcbc0ee8f33fb7295cbc7ee12bffe62a320f167e38b060b00",
         intel: "6db1ab5dd8414aaa1a97ad5862fbd8d1a87ac9914fb8e4106aafa7b3015cf75e"

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

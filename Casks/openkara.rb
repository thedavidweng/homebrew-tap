cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.17.3"
  sha256 arm:   "bca7c37d0bb9b45b2d6089ded985476271172dd4ea184b0e12394c1e7844b373",
         intel: "e6472e3aa753659722d31058c1bce21f6eb16bebdb97e6c9306dc9f8bde6bcc6"

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

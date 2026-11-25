cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.21.1"
  sha256 arm:   "0673a491d789f12ec2862ffe13df118fdefadbed7ad95a10cdbe509c4678b3c3",
         intel: "5782b581d33b69ad200e5ecd735ae3baa9d2eb91d298f790a8047d05db87f62c"

  url "https://github.com/thedavidweng/OpenKara/releases/download/v#{version}/OpenKara_#{version}_#{arch}.dmg"
  name "OpenKara"
  desc "Open-source karaoke player"
  homepage "https://github.com/thedavidweng/OpenKara"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "OpenKara.app"
end

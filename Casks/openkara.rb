cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.20.0"
  sha256 arm:   "56eb7fa93f34d8050f4a1f2a4249b8af27e039c3fa780060748408d76572fa85",
         intel: "3f5eb642617010399ffe1449546736700b7ed7c5befe7be9bceca53d82f400d4"

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

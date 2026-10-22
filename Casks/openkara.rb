cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.17.1"
  sha256 arm:   "c36be26d931d28887faf54db5b4ae052a7b6f98a483ae5382be59d96f23d59c5",
         intel: "236c1caafb2806e1c815639eed8044e1f16e7382478c2732b8ccf3ebd60d633f"

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

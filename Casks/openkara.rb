cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.4.0"
  sha256 arm:   "cf71186e15f0e18bfd21b47ddc6e0185827232e31f6076c0d3b2e1fecb1c8b9f",
         intel: "968fb3acf41adfae2884a479ebc39c4552d300e164f0f490c1a03321fdeb896b"

  url "https://github.com/thedavidweng/OpenKara/releases/download/v#{version}/OpenKara_#{version}_#{arch}.dmg"
  name "OpenKara"
  desc "Open source karaoke player for macOS"
  homepage "https://github.com/thedavidweng/OpenKara"

  app "OpenKara.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-rd", "com.apple.quarantine", "#{appdir}/OpenKara.app"]
  end

  livecheck do
    url :url
    strategy :github_latest
  end
end

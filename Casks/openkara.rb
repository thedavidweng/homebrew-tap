cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.12.0"
  sha256 arm:   "6e03e1213d33a18d8f3a5df4d0783a21c2df7d27b644e30110a0f80e41dba173",
         intel: "043be9dfe54697b0d048574e7c729940b87b99686a73def60e21441ee55f4db0"

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

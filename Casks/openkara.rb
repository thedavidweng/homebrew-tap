cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.2.0"
  sha256 arm:   "b073b7efa6b169e29b4afb96f2e7c1c50831bef5668d4063e27a15efb9510de7",
         intel: "d62dbc15165f594a0c782c416504886f3144e031800083834c279e5430551d14"

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

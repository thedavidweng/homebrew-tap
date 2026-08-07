cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.13.0"
  sha256 arm:   "17754661e26752aebd0278ca1dea518b660f96f45e8527a8486f2d034e5d5d7e",
         intel: "34e55da44c198a4c10463ef1d1e98f4d41ad633eab1a0655cb5dfb38f451c959"

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

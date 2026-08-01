cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.11.0"
  sha256 arm:   "424211d3bb606e6f4428d193747fc0d635e80f1883245be9c311d7e144b5745b",
         intel: "08c3206619084725be566fd474e66eccf9fc81f45d8dfd3628925ca8ed87fce0"

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

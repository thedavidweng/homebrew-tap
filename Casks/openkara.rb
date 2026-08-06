cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.12.1"
  sha256 arm:   "c13131b9a04b159a9d816b3d9596ada3d2fae18ac4aeb9dc92f5e40ad8f7de3f",
         intel: "9383f4c8b5b3681cba58a5cdb6538e41834b471ec810e85b3f9712cb04ad4b93"

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

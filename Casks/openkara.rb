cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.5.1"
  sha256 arm:   "40597d47fc4c1d983c6a74166b9d16884a8b6032b62fe67b3a6369404fda8d2f",
         intel: "b5ad7114f0e4b5414080ac51747624d70a4603773b041bb5400d678c8b812191"

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

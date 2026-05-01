cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.7.0"
  sha256 arm:   "5255080cf27aba7082456712b0005028d5694a7e4145a3a4081fa8bd72e2c9b4",
         intel: "ca82bb918625120346954b6c4b581ea6aa7d0672d44101a0e3a1b6c00a8a9bfd"

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

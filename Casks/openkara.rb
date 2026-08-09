cask "openkara" do
  arch arm: "aarch64", intel: "x64"

  version "0.13.1"
  sha256 arm:   "6c182623a4d461efbb7a2a5083bea669b08295e71ff208e008053d33e1ab86dc",
         intel: "ca7a1781687e7c8cee19b63f714ff9d985363611ecad2dffd4e2f39d026143ee"

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

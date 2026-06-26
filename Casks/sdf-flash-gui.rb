cask "sdf-flash-gui" do
  version "0.2.0"

  on_arm do
    sha256 "22372ba55b329a544d1f7f59fe6b7bb217bfb47c34f3e3b11592c90be14375dc"
    url "https://github.com/thedavidweng/sdf-flash-gui/releases/download/v0.2.0/SDF.Flash.GUI_0.2.0_aarch64.dmg"
  end
  on_intel do
    sha256 "4440546e5e75079f1a4143519665cf8788ff63c0adc692ef751680ba77880d51"
    url "https://github.com/thedavidweng/sdf-flash-gui/releases/download/v0.2.0/SDF.Flash.GUI_0.2.0_x64.dmg"
  end

  name "SDF Flash GUI"
  desc "Cross-platform GUI for flashing optical drives"
  homepage "https://github.com/thedavidweng/sdf-flash-gui"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "SDF Flash GUI.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-rd", "com.apple.quarantine", "#{appdir}/SDF Flash GUI.app"]
  end
end
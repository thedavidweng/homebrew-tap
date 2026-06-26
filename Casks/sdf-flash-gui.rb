cask "sdf-flash-gui" do
  version "0.2.0"

  on_arm do
    sha256 "71045ee4c9ad3c992c922c028b53f9c126454da54bdeb7a6bc811b67de4d9376"
    url "https://github.com/thedavidweng/sdf-flash-gui/releases/download/v0.2.0/SDFFlashGUI_0.2.0_aarch64.dmg"
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
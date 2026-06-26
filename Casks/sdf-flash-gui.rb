cask "sdf-flash-gui" do
  version "0.2.0"

  on_arm do
    sha256 "71045ee4c9ad3c992c922c028b53f9c126454da54bdeb7a6bc811b67de4d9376"
    url "https://github.com/thedavidweng/sdf-flash-gui/releases/download/v0.2.0/SDFFlashGUI_0.2.0_aarch64.dmg"
  end
  on_intel do
    sha256 "ac3696dd208cbda247dbc05c3937e3cf90e367b0f994b25a068881aad9b4115c"
    url "https://github.com/thedavidweng/sdf-flash-gui/releases/download/v0.2.0/SDFFlashGUI_0.2.0_x64.dmg"
  end

  name "SDFFlashGUI"
  desc "Cross-platform GUI for flashing optical drives"
  homepage "https://github.com/thedavidweng/sdf-flash-gui"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "SDFFlashGUI.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-rd", "com.apple.quarantine", "#{appdir}/SDFFlashGUI.app"]
  end
end
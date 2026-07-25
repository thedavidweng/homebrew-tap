cask "sdf-flash-gui" do
  version "1.0.0"

  on_arm do
    sha256 "56c32ebc97324be2f6d808a69c9be3303df2d63ec02bc227ffd4fd5c9ca7e2f5"
    url "https://github.com/thedavidweng/sdf-flash-gui/releases/download/v1.0.0/SDF.Flash.GUI_1.0.0_aarch64.dmg"
  end
  on_intel do
    sha256 "ec3b8a2712051f1dc5ca0341aba7dbd9e79c1ab50deb76b39717bf3ee61d313f"
    url "https://github.com/thedavidweng/sdf-flash-gui/releases/download/v1.0.0/SDF.Flash.GUI_1.0.0_x64.dmg"
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
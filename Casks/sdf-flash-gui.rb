cask "sdf-flash-gui" do
  version "1.1.0"

  on_arm do
    sha256 "dfb461cc10db1f38df241b866f47e75f6de2a1e449bd57d5c7f3995e2abd8345"
    url "https://github.com/thedavidweng/sdf-flash-gui/releases/download/v#{version}/SDF.Flash.GUI_#{version}_aarch64.dmg"
  end
  on_intel do
    sha256 "728319512ed0b2429da2872a63bcd31822eb9b97423c74eced4032b13f66cfb6"
    url "https://github.com/thedavidweng/sdf-flash-gui/releases/download/v#{version}/SDF.Flash.GUI_#{version}_x64.dmg"
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

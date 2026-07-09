cask "sdf-flash-gui" do
  version "0.3.0"

  on_arm do
    sha256 "391b0bf31f25161d7e762ae547e40386801df57faee71a41df66835b5828dfe7"
    url "https://github.com/thedavidweng/sdf-flash-gui/releases/download/v#{version}/SDF.Flash.GUI_#{version}_aarch64.dmg"
  end
  on_intel do
    sha256 "598e443a1cf142d135c19d6c4aa7748be72e6ea41205d53305af87d3930c593b"
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
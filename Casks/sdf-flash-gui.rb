cask "sdf-flash-gui" do
  version "0.4.0"

  on_arm do
    sha256 "63ea0e2df7aa53de0d4d5cc7f80a8725bcf56ffdca0862b3b6148268d51708a7"
    url "https://github.com/thedavidweng/sdf-flash-gui/releases/download/v#{version}/SDF.Flash.GUI_#{version}_aarch64.dmg"
  end
  on_intel do
    sha256 "ae916882801c358c67eb5e41a8d8aff3ba5bc9e40985cb5f6d64d2f7804b564c"
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
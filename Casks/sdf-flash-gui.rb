cask "sdf-flash-gui" do
  version "1.1.2"

  on_arm do
    sha256 "bd2b5ba4d886ecb6264ae24cf2fe0a96c6a02cc102a08660b1ee5e6ff70b83ae"

    url "https://github.com/thedavidweng/sdf-flash-gui/releases/download/v#{version}/SDF.Flash.GUI_#{version}_aarch64.dmg"
  end
  on_intel do
    sha256 "a9d13d5df1c5b5c9d1843fdd642e46a4279d561631a2e95cd29df2fa9bd2c5dd"

    url "https://github.com/thedavidweng/sdf-flash-gui/releases/download/v#{version}/SDF.Flash.GUI_#{version}_x64.dmg"
  end

  name "SDF Flash GUI"
  desc "Cross-platform GUI for flashing optical drives"
  homepage "https://github.com/thedavidweng/sdf-flash-gui"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "SDF Flash GUI.app"
end

cask "sdf-flash-gui" do
  version "1.1.4"

  on_arm do
    sha256 "6be873ec2c5f7bd3546e94759885b83158968f1ae824990bc166b2cb1e50c17b"

    url "https://github.com/thedavidweng/sdf-flash-gui/releases/download/v#{version}/SDF.Flash.GUI_#{version}_aarch64.dmg"
  end
  on_intel do
    sha256 "8ee8f7ea848a6b4ae0acc68eb96a14794f613e499a33a76ffa20e1cd6dbebaeb"

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

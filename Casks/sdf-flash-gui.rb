cask "sdf-flash-gui" do
  version "1.1.3"

  on_arm do
    sha256 "1c2307fe2521c45068c8b27a2af8174669bd5a663e8bb7b9d7d1df6cde951173"

    url "https://github.com/thedavidweng/sdf-flash-gui/releases/download/v#{version}/SDF.Flash.GUI_#{version}_aarch64.dmg"
  end
  on_intel do
    sha256 "827fb5275712bd80ae5e0d1902e7ca1dd1933a4aaeea0b7e2e43d461748982e6"

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

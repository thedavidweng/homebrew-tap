cask "fluidvoice" do
  version "1.5.13"
  sha256 "f650ac156da289d85818e434913dc116bbc7d8030c40285aabb4fd53aee01e8e"

  url "https://github.com/altic-dev/FluidVoice/releases/download/v#{version}/Fluid-oss-#{version}.dmg"
  name "FluidVoice"
  desc "Fast offline dictation app for macOS"
  homepage "https://github.com/altic-dev/FluidVoice"

  depends_on macos: ">= :sequoia"

  app "FluidVoice.app"

  livecheck do
    url :url
    strategy :github_latest
  end
end

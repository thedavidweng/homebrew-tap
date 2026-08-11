cask "fluidvoice" do
  version "1.6.8"
  sha256 "04027196113095819ff7c5eda91d1795ad427d45ace28f8a55a20b5bc2b02161"

  url "https://github.com/altic-dev/FluidVoice/releases/download/v#{version}/Fluid-oss-#{version}.dmg"
  name "FluidVoice"
  desc "Fast offline dictation app for macOS"
  homepage "https://github.com/altic-dev/FluidVoice"

  depends_on macos: :sequoia

  app "FluidVoice.app"

  livecheck do
    url :url
    strategy :github_latest
  end
end

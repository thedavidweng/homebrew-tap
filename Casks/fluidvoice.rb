cask "fluidvoice" do
  version "1.6.5"
  sha256 "25fbbbb604f26865d1e05ec60359ef7f7fa04a4b4a6bb238e84013d87686bd65"

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

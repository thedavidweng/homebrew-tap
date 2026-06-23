cask "fluidvoice" do
  version "1.6.0"
  sha256 "3375e57e871cbc49663eaa3dfa49e13d2432fee4e86c3427603b0993729e8100"

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

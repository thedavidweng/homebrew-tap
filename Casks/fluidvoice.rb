cask "fluidvoice" do
  version "1.5.12"
  sha256 "c7e306236f0424be72bc76a3519c406bb51ab749778a9f815bcf9e9c1da16e86"

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

cask "fluidvoice" do
  version "1.6.6"
  sha256 "9087f85af0a7563ed4594e644728049faee0a9ef3176d8517516c5b473ad0fdf"

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

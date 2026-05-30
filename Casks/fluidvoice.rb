cask "fluidvoice" do
  version "1.5.14"
  sha256 "601adea45d3034c64f3a3ccb658d6b36728c9b7b1fa19e2768999372d0a228bb"

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

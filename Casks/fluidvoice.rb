cask "fluidvoice" do
  version "1.6.13"
  sha256 "8da47aba78de572973c287ab5e33d9eefc4b8938f69bbff99249e28900ce49aa"

  url "https://github.com/altic-dev/FluidVoice/releases/download/v#{version}/Fluid-oss-#{version}.dmg"
  name "FluidVoice"
  desc "Fast offline dictation app"
  homepage "https://github.com/altic-dev/FluidVoice"

  livecheck do
    url :url
    regex(/^v(\d+\.\d+\.\d+)$/i)
    strategy :github_releases
  end

  depends_on macos: :sequoia

  app "FluidVoice.app"
end

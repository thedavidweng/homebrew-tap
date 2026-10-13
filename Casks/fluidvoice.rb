cask "fluidvoice" do
  version "1.6.11"
  sha256 "a481aef2f1c36ab215671dc0cc20ce9a9cd460d51e75b87b095a83232eec5065"

  url "https://github.com/altic-dev/FluidVoice/releases/download/v#{version}/Fluid-oss-#{version}.dmg"
  name "FluidVoice"
  desc "Fast offline dictation app"
  homepage "https://github.com/altic-dev/FluidVoice"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia

  app "FluidVoice.app"
end

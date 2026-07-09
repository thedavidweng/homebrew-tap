cask "fluidvoice" do
  version "1.6.2"
  sha256 "85b59903ec19694e11d75d4aacb558c945ce3664062f7f75f8cb3ccf706b1bf3"

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

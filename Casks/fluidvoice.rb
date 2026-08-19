cask "fluidvoice" do
  version "1.6.9"
  sha256 "d8fb7861d479748bb9905b34e058bc0b106efb3c1767b397f9b2cb604a9357a7"

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

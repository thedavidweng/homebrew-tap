cask "fluidvoice" do
  version "1.6.12"
  sha256 "1560f07ebd986f6315f569c0e7362e425490dd8227364b6c09fbf77426f46d9f"

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

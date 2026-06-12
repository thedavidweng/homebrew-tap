cask "fluidvoice" do
  version "1.5.15"
  sha256 "137fb8f39f6ad8d786492d9db733068c3f160601a2d229af385c4d4822b6b515"

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

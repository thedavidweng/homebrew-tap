cask "openloop" do
  version "0.2.2"
  sha256 "dece62f1352c5ff57eaf769a2a873a76d4ce8fb249dda9138968e8e117677c46"

  url "https://github.com/thedavidweng/OpenLoop/releases/download/v#{version}/OpenLoop_#{version}_aarch64.dmg"
  name "OpenLoop"
  desc "AI music generation desktop application"
  homepage "https://github.com/thedavidweng/OpenLoop"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "OpenLoop.app"
  binary "#{appdir}/OpenLoop.app/Contents/MacOS/openloop-cli", target: "openloop"

  zap trash: [
    "~/Library/Application Support/openloop",
    "~/Library/Application Support/OpenLoop",
    "~/Library/Logs/openloop",
    "~/Music/OpenLoop",
  ]
end

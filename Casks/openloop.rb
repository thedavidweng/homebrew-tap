cask "openloop" do
  version "0.1.0"
  sha256 :no_check

  url "https://github.com/openloop/openloop/releases/download/v#{version}/OpenLoop_#{version}_aarch64.dmg"
  name "OpenLoop"
  desc "AI music generation desktop application"
  homepage "https://github.com/openloop/openloop"

  depends_on macos: ">= :sonoma"

  app "OpenLoop.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/OpenLoop.app"]
    system_command "/bin/ln",
                   args: ["-sf", "#{appdir}/OpenLoop.app/Contents/MacOS/openloop", "/usr/local/bin/openloop"],
                   sudo: true
  end

  zap trash: [
    "~/Library/Application Support/openloop",
    "~/Library/Application Support/OpenLoop",
    "~/Music/OpenLoop",
    "~/Library/Logs/openloop",
  ]
end

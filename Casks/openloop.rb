cask "openloop" do
  version "0.1.0"
  sha256 "c67adec16a2ff384556d95f5c457f740686b11a21ce835d5031d1d5df2442741"

  url "https://github.com/thedavidweng/OpenLoop/releases/download/v#{version}/OpenLoop_#{version}_aarch64.dmg"
  name "OpenLoop"
  desc "AI music generation desktop application"
  homepage "https://github.com/thedavidweng/OpenLoop"

  depends_on arch: :arm64
  depends_on macos: :sonoma

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

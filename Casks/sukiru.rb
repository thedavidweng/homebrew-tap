cask "sukiru" do
  version "1.5.0"
  sha256 "e67a87574ac95ec16fe5cd477394c37276cd37dbd68a66d355366e2fc07c7025"

  url "https://github.com/thedavidweng/sukiru/releases/download/v#{version}/Sukiru.dmg"
  name "Sukiru"
  desc "Checks, repairs, and installs skills for coding agents"
  homepage "https://thedavidweng.github.io/sukiru/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Sukiru.app"
  binary "#{appdir}/Sukiru.app/Contents/MacOS/sukiru", target: "sukiru"

  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-rd", "com.apple.quarantine", "{{appdir}}/Sukiru.app"]
  end

  zap trash: [
    "~/Library/Application Support/Sukiru",
    "~/Library/Saved Application State/app.sukiru.savedState",
  ]
end

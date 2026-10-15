cask "sukiru" do
  version "1.5.1"
  sha256 "9be232fc0159e17bc0389909f68b960ea02c40d46e38692236c5c54d2f085da3"

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

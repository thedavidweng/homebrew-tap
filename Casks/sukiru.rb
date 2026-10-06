cask "sukiru" do
  version "1.4.0"
  sha256 "79035425edece7aa5457aad3aa6361cd65c1433b347261a200f6e1f13d42fe05"

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

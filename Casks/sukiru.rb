cask "sukiru" do
  # The first release is not published yet; scripts/sync_cask_release.py
  # fills version and sha256 from the latest GitHub release once it exists.
  version "1.0.0"
  sha256 :no_check

  url "https://github.com/thedavidweng/sukiru/releases/download/v#{version}/Sukiru.dmg"
  name "Sukiru"
  desc "Native macOS skill-library health checker and repairer"
  homepage "https://github.com/thedavidweng/sukiru"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Sukiru.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-rd", "com.apple.quarantine", "{{appdir}}/Sukiru.app"]
  end

  zap trash: [
    "~/Library/Application Support/Sukiru",
    "~/Library/Saved Application State/app.sukiru.savedState",
  ]
end

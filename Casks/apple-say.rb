cask "apple-say" do
  version "1.0.0"
  sha256 "63b33591e7097a8e323a56c6f67fdd03c528bf1b52f34a47ee7c2c93bea2f842"

  url "https://github.com/thedavidweng/apple-say/releases/download/v#{version}/Apple-Say.dmg"
  name "Apple Say"
  desc "Studio for speech synthesis and timed text audio production"
  homepage "https://github.com/thedavidweng/apple-say"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Apple Say.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-rd", "com.apple.quarantine", "{{appdir}}/Apple Say.app"]
  end

  zap trash: [
    "~/Library/Preferences/com.thedavidweng.apple-say.plist",
    "~/Library/Saved Application State/com.thedavidweng.apple-say.savedState",
  ]
end

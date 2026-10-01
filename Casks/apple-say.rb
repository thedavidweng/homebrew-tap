cask "apple-say" do
  version "1.2.1"
  sha256 "a7ca8df9b77fc12690e13be0fef3fae9078d3677609eb658bd79511c5ff93011"

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

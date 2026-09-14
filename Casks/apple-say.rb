cask "apple-say" do
  version "1.0.0"
  sha256 "304411b917d6458bf71a0ea52c4a517697d0cc948389d120017e21be046360c2"

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

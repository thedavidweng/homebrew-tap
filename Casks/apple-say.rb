cask "apple-say" do
  version "1.2.2"
  sha256 "e97045c93f487c1b9bf92f3c8039be8e8a4ade6b19cdab852b5974a9d045b7b5"

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

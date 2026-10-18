cask "apple-say" do
  version "1.2.4"
  sha256 "951bf2ba013e0a76389f3632ade2039e6c06ceca166c8bc216e7e9e983bea02c"

  url "https://github.com/thedavidweng/apple-say/releases/download/v#{version}/Apple-Say.dmg"
  name "Apple Say"
  desc "Studio for speech synthesis and timed text audio production"
  homepage "https://github.com/thedavidweng/apple-say"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Apple Say.app"

  zap trash: [
    "~/Library/Preferences/com.thedavidweng.apple-say.plist",
    "~/Library/Saved Application State/com.thedavidweng.apple-say.savedState",
  ]
end

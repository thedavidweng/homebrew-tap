cask "wiiu-downloader" do
  version "3.2"
  sha256 "278a201c4e5648049d729a1cfbb0ad75d71d4af6e2b0384454cdd2609919817d"

  url "https://github.com/Xpl0itU/WiiUDownloader/releases/download/v#{version}/WiiUDownloader-macOS-Universal.dmg"
  name "WiiUDownloader"
  desc "Download Wii U games, updates, DLC and demos from Nintendo's servers"
  homepage "https://github.com/Xpl0itU/WiiUDownloader"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "WiiUDownloader.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-rd", "com.apple.quarantine", "{{appdir}}/WiiUDownloader.app"]
  end

  zap trash: [
    "~/Library/Application Support/WiiUDownloader",
    "~/Library/Caches/com.Xpl0itU.WiiUDownloader",
    "~/Library/Preferences/com.Xpl0itU.WiiUDownloader.plist",
    "~/Library/Saved Application State/com.Xpl0itU.WiiUDownloader.savedState",
  ]
end

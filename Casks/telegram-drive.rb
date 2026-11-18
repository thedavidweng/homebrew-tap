cask "telegram-drive" do
  arch arm: "aarch64", intel: "x64"

  version "4.1.7"
  sha256 arm:   "2e88bb90293f7aba052abc4575e788546a2d102b3675e7b173649121aa4785fd",
         intel: "7a4e57b2a3eadf34266b3f2ec1e6be7ca90fc95a48e9de020b26ccb5300caa18"

  url "https://github.com/caamer20/Telegram-Drive/releases/download/v#{version}/Telegram.Drive_#{version}_#{arch}.dmg"
  name "Telegram Drive"
  desc "Browse, upload, and download files on Telegram with a native file manager"
  homepage "https://github.com/caamer20/Telegram-Drive"

  livecheck do
    url "https://github.com/caamer20/Telegram-Drive/releases/latest/download/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  auto_updates true
  # Tauri 2.11/objc2 uses WebKit APIs that predate Big Sur and panic at launch
  # on older systems. `depends_on :macos` is the current Homebrew runtime
  # floor, so no extra minimum is declared.
  depends_on :macos

  app "Telegram Drive.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-rd", "com.apple.quarantine", "{{appdir}}/Telegram Drive.app"]
  end

  zap trash: [
    "~/Library/Application Support/com.cameronamer.telegramdrive",
    "~/Library/Caches/com.cameronamer.telegramdrive",
    "~/Library/HTTPStorages/com.cameronamer.telegramdrive",
    "~/Library/Preferences/com.cameronamer.telegramdrive.plist",
    "~/Library/Saved Application State/com.cameronamer.telegramdrive.savedState",
    "~/Library/WebKit/com.cameronamer.telegramdrive",
  ]
end

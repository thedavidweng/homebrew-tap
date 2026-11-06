cask "telegram-drive" do
  arch arm: "aarch64", intel: "x64"

  version "4.1.3"
  sha256 arm:   "023f538d13537f05df092fec41463015ebd22c0d8c958f14cc269ed0cb83ffbd",
         intel: "5a9403c9e2f89f0414089ad476d89ad1359ce39f8b567edb5c789f4f2972121b"

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

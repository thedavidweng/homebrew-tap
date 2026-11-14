cask "telegram-drive" do
  arch arm: "aarch64", intel: "x64"

  version "4.1.5"
  sha256 arm:   "a0507fe24f5c7a425d0dd437cf153c62f6599224fbeed79aa171a625b9590230",
         intel: "62c43e4f8b40a3dee601dac2a230e6281cf2988392afb3b352d5349522a015a7"

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

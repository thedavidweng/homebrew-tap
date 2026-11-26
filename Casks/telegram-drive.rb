cask "telegram-drive" do
  arch arm: "aarch64", intel: "x64"

  version "4.2.0"
  sha256 arm:   "28d9fb38736fb08bf1a4a4faadb4ee708889bc8cdfbce011f7e0b9d38c4b5442",
         intel: "29850a159dac20a9ce9a7d641be45cb1a7798946359a0fe0e0d06356f0504513"

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

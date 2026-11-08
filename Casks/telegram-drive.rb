cask "telegram-drive" do
  arch arm: "aarch64", intel: "x64"

  version "4.1.4"
  sha256 arm:   "fc2aaf4404e024bc4a7102b0597fc39ae9e816740d29a9b451acb128e6389d1f",
         intel: "57f9c6ff5fd245529e3234668da378d50a223bccc1ff1da7da0df68fbd8f7b2b"

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

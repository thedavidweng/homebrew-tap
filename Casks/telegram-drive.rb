cask "telegram-drive" do
  arch arm: "aarch64", intel: "x64"

  version "1.9.7"
  sha256 arm:   "83726d8d7d2c525f2aa3254f504cfa648f3cc0b4bf2455bc03aa694e4a3fba72",
         intel: "20c7d8ddf171f961e2bd0ba508a3c6a892d1efa1d9d08738eb19a3ce19c21cf7"

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
  depends_on macos: :catalina

  app "Telegram Drive.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-rd", "com.apple.quarantine", "#{appdir}/Telegram Drive.app"]
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

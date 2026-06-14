cask "notchprompt" do
  version "1.1.3"

  on_arm do
    sha256 "a4a72efdd7ccab153784a62bbdbbb7d5a379f10ec65c8995194b4b5c2e714ccd"
    url "https://github.com/saif0200/notchprompt/releases/download/v#{version}/notchprompt-v#{version}-apple-silicon.dmg"
  end
  on_intel do
    sha256 "7e225babf60caae3308193876cb8b658b0696e15f192c8135d54a3c76fa13f65"
    url "https://github.com/saif0200/notchprompt/releases/download/v#{version}/notchprompt-v#{version}-intel.dmg"
  end

  name "NotchPrompt"
  desc "Menu bar teleprompter for presentations and recordings"
  homepage "https://github.com/saif0200/notchprompt"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "notchprompt.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-rd", "com.apple.quarantine", "#{appdir}/notchprompt.app"]
  end

  zap trash: [
    "~/Library/Application Support/notchprompt",
    "~/Library/Preferences/com.saif0200.notchprompt.plist",
  ]
end

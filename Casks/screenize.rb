cask "screenize" do
  version "0.4.3"
  sha256 "46940f6c03631305a72b8d05cda7faea76ebd20a1408953579c796a87440d00d"

  url "https://github.com/syi0808/screenize/releases/download/v#{version}/Screenize.dmg"
  name "Screenize"
  desc "Screen recording editor for macOS"
  homepage "https://github.com/syi0808/screenize"

  app "Screenize.app"

  livecheck do
    url :url
    strategy :github_latest
  end
end

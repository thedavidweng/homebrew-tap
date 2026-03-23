cask "screenize" do
  version "0.4.1"
  sha256 "1402af55a5f2d7c34e384753df65bc32a6d59eed75059e00230312902e88cadb"

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

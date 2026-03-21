cask "screenize" do
  version "0.4.0"
  sha256 "a401695a1a05cfaa158fd04cd6c2ef61af3b0a62c3f9f3d6284dd9da235f9271"

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

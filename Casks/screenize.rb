cask "screenize" do
  version "0.4.2"
  sha256 "a26845e1b3669a9649551a0e77d96b31cb33f3a2b509af4065ea150a6128b76e"

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

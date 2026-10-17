cask "strudel-tui" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.0"
  sha256 arm:   "95330ed50e950a3af63c693e04bcdb1de5382593bd4c6e951181ead252181b5f",
         intel: "b25579e155f9f11e3a34916ebddfb3b1438387c8c860cd65fe7024f3879205d6"

  url "https://github.com/thedavidweng/strudel-tui/releases/download/v#{version}/strudel-tui-darwin-#{arch}.tar.gz"
  name "Strudel TUI"
  desc "Terminal-based live coding interface for Strudel with AI agent"
  homepage "https://github.com/thedavidweng/strudel-tui"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "strudel-tui"
end

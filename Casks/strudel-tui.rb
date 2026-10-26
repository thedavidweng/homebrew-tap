cask "strudel-tui" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.2"
  sha256 arm:   "c0f0c6384da2b5c57902774d1f124c2bcf3447b4d745f005173bf927f193fd68",
         intel: "615745de272c63aa5db351c07f53b6290e9f839cc6d3924264903e23756b5b2b"

  url "https://github.com/thedavidweng/strudel-tui/releases/download/v#{version}/strudel-tui-darwin-#{arch}.tar.gz"
  name "Strudel TUI"
  desc "Terminal-based live coding interface for Strudel with AI agent"
  homepage "https://github.com/thedavidweng/strudel-tui"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  binary "strudel-tui"
end

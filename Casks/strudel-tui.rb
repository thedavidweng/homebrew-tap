cask "strudel-tui" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.1"
  sha256 arm:   "349b21e862b89fbcd6bde5ad83ba4831cb35c86e257782baac14af72f377b52b",
         intel: "7c97933fd6e0799319ad9497a68b2a41cabc3d67f9fd34aea0ddd27564e4ae3c"

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

cask "flickr" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "0.3.6"
  sha256 arm:          "96c1b668729a82b04014aa1d9cff1633c0773304010b4a143c2576380acb3e29",
         intel:        "2403c04cac82df8bdcd16780319e34c77134f24454fe8c2e2f763546f8963af2",
         arm64_linux:  "228359b8cae11b69389cb16dd8e9780379c4b8651a5dcd9c5433f5d48fb54235",
         x86_64_linux: "8e8eac41e14250ef93f13111d34d69f31f2fee9ede715477b524c78b0e9f536a"

  url "https://github.com/thedavidweng/flickr-cli/releases/download/v#{version}/flickr_#{version}_#{os}_#{arch}.tar.gz"
  name "flickr"
  desc "Agent-friendly CLI for Flickr photo management, backup, upload, and API access"
  homepage "https://github.com/thedavidweng/flickr-cli"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "flickr"
  generate_completions_from_executable "flickr", "completion"

  zap :not_required
end

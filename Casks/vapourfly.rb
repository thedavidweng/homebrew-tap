cask "vapourfly" do
  version "0.3.1"
  sha256 "1f79b1bfd9a9a94b743e74f2858e8335b8674dda28f304306b31889d0d7dcfd8"

  url "https://github.com/thedavidweng/vapourfly/releases/download/v#{version}/vapourfly-macos-aarch64.tar.gz"
  name "Vapourfly"
  desc "Local-first Steam library manager and playlist organizer"
  homepage "https://thedavidweng.github.io/vapourfly/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "vapourfly-macos-aarch64/Vapourfly.app"
  binary "vapourfly-macos-aarch64/vapourfly"

  zap trash: [
    "~/Library/Application Support/vapourfly",
    "~/Library/Caches/vapourfly",
  ]
end

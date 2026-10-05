cask "vapourfly" do
  version "0.3.0"
  sha256 "8ed2bf86223871c1682ad34d6315d88af649e18cf4e384ac735079be6d2ce829"

  url "https://github.com/thedavidweng/vapourfly/releases/download/v#{version}/vapourfly-macos-aarch64.tar.gz"
  name "Vapourfly"
  desc "Local-first Steam library manager and playlist organizer"
  homepage "https://thedavidweng.github.io/vapourfly/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64

  app "vapourfly-macos-aarch64/Vapourfly.app"
  binary "vapourfly-macos-aarch64/vapourfly"

  postflight_steps do
    on_macos do
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Vapourfly.app"]
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{staged_path}}/vapourfly-macos-aarch64/vapourfly"]
    end
  end

  zap trash: [
    "~/Library/Application Support/vapourfly",
    "~/Library/Caches/vapourfly",
  ]
end

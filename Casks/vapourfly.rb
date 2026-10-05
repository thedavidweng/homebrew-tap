cask "vapourfly" do
  version "0.3.0"
  sha256 "cc1e891162faa996fac8171cf8e3bc692492f7c361dbf9c8010483609ca718f5"

  url "https://github.com/thedavidweng/vapourfly/releases/download/v#{version}/vapourfly-macos-aarch64.tar.gz"
  name "Vapourfly"
  desc "Local-first Steam library manager and playlist organizer"
  homepage "https://thedavidweng.github.io/vapourfly/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64

  binary "vapourfly-macos-aarch64/vapourfly"
  binary "vapourfly-macos-aarch64/vapourfly-gui"

  postflight_steps do
    on_macos do
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{staged_path}}/vapourfly-macos-aarch64"]
    end
  end

  zap trash: [
    "~/Library/Application Support/vapourfly",
    "~/Library/Caches/vapourfly",
  ]
end

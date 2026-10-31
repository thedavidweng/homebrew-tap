cask "jobs-cli" do
  arch arm: "arm64", intel: "x86_64"

  version "2.1.2"
  sha256 arm:          "94cecaf172a38cc7a94218b42f1ab9ee454a60a51dca9d4bede6ac61d3b275ec",
         intel:        "94cecaf172a38cc7a94218b42f1ab9ee454a60a51dca9d4bede6ac61d3b275ec",
         arm64_linux:  "37e3ea363bd4a4989c0a6fdd85a8582863c2b71ddc9c52e2c9c6b7fbaa9422d9",
         x86_64_linux: "4effbe92b8beb5430f96ab83a8f39d5cf19438a42ddca584b0039e1653e42a4a"

  on_macos do
    url "https://github.com/thedavidweng/jobs-cli/releases/download/v#{version}/jobs-cli_darwin_universal.tar.gz"
  end
  on_linux do
    url "https://github.com/thedavidweng/jobs-cli/releases/download/v#{version}/jobs-cli_linux_#{arch}.tar.gz"
  end

  name "jobs-cli"
  desc "Agent-friendly CLI for job discovery and applications"
  homepage "https://github.com/thedavidweng/jobs-cli"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "jobs-cli"

  postflight_steps do
    on_macos do
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{staged_path}}/jobs-cli"]
    end
  end

  zap :not_required
end

cask "monarchmoney-cli" do
  arch arm: "arm64", intel: "x86_64"
  os macos: "darwin", linux: "linux"

  version "0.12.3"
  sha256 arm:          "97fa991f55ff02c50bbd7d9f642712c4f57e84d7bf2043e52252e3f00d3b5368",
         intel:        "b102a111d9d37c01d9146412ee567ce88e8204056c8565a31f9fe9d2e059fe86",
         arm64_linux:  "2cc63dfaf0a9aeb19fabc98fd92033ff07207861a402fe1fe0bf691582cafcdf",
         x86_64_linux: "91803c6ceb24610c01b4c556fab138959ffe563037d9d9408697480c62c52653"

  url "https://github.com/thedavidweng/monarchmoney-cli/releases/download/v#{version}/monarch_#{os}_#{arch}.tar.gz"
  name "monarchmoney-cli"
  desc "Local, agent-friendly CLI for Monarch Money"
  homepage "https://github.com/thedavidweng/monarchmoney-cli"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "monarch"

  postflight_steps do
    on_macos do
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{staged_path}}/monarch"]
    end
  end

  zap :not_required
end

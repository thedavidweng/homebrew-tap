cask "money" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "0.4.3"
  sha256 arm:          "71ef2f699e4baca9ba78bc9b15f40dc16910ea78fc2165e98bce7e2e7fb8938c",
         intel:        "73e3ee4935dd0982aca973d24579957eeb7f312ea5b34fa955e9771acdd2bc97",
         arm64_linux:  "90821630157d12ba6aa167966972b0ef390bcb6d7ed0611f7dda169e555786f0",
         x86_64_linux: "4919816a80d2a939c0a42048aedb7a483ff729830ae446c92c2b68416a54b549"

  url "https://github.com/thedavidweng/money/releases/download/v#{version}/money_#{version}_#{os}_#{arch}.tar.gz"
  name "money"
  desc "Local-first personal finance backend for agents and power users"
  homepage "https://github.com/thedavidweng/money"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "money"

  postflight_steps do
    on_macos do
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{staged_path}}/money"]
    end
  end

  zap :not_required
end

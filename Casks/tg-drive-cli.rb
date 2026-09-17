cask "tg-drive-cli" do
  version "0.2.0"
  # TODO: replace with the real v0.2.0 checksums.txt value before merging.
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/thedavidweng/tg-drive-cli/releases/download/v#{version}/td_darwin_universal.tar.gz"
  name "tg-drive-cli"
  desc "Telegram-backed virtual file tree CLI"
  homepage "https://github.com/thedavidweng/tg-drive-cli"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "td"
  generate_completions_from_executable "td", "completion",
                                       shell_parameter_format: :cobra,
                                       shells:                 [:bash, :zsh, :fish]

  postflight_steps do
    on_macos do
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{staged_path}}/td"]
    end
  end

  # No zap stanza required
end

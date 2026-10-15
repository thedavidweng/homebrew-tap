cask "tg-drive" do
  version "1.0.0"
  sha256 "b54c0bc2d9034858296cb37c75e6a5954ef65291379c64127a9bb95854fd2ac7"

  url "https://github.com/thedavidweng/tg-drive/releases/download/v#{version}/td_darwin_universal.tar.gz"
  name "tg-drive"
  desc "Telegram-backed virtual file tree CLI"
  homepage "https://github.com/thedavidweng/tg-drive"

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

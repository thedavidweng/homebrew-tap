cask "tg-drive-cli" do
  version "0.2.1"
  sha256 "a4d5fee1d7d1c66499777d34b689d0c83532690dc65abede8cf7136d7d36e8fd"

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

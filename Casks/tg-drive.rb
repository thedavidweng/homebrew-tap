cask "tg-drive" do
  version "1.2.0"
  sha256 "999bf9ef0de2165a4d3cb82da33af513e901201a9196523d10c976a453e0af80"

  url "https://github.com/thedavidweng/tg-drive/releases/download/v#{version}/td_darwin_universal.tar.gz"
  name "tg-drive"
  desc "Telegram-backed virtual file tree CLI"
  homepage "https://github.com/thedavidweng/tg-drive"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  binary "td"
  generate_completions_from_executable "td",
                                       shell_parameter_format: :cobra,
                                       shells:                 [:bash, :zsh, :fish]
end

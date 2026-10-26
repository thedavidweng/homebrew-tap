cask "tg-drive" do
  version "1.1.1"
  sha256 "567f4631702a06c6702d0cc92e8c7251f94c478416f5f751cc562eede6985d57"

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

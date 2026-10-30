cask "tg-drive" do
  version "1.2.1"
  sha256 "a177cbda4c03ffc8a890c9091bbe21bf5bfe2fd5f9f094fbae8e47c9852a4674"

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

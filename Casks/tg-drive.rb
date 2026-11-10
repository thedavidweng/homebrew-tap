cask "tg-drive" do
  version "1.2.2"
  sha256 "0ed334fb10b605f544abbb9b9d87c5a927e41f64b468f45806ed0df33bf4772d"

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

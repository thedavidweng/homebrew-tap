cask "tg-drive" do
  version "1.0.1"
  sha256 "2973c81c11590dbb564a091541fd8d8e441a0a98df3a2f859dcc4c0601b7444e"

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

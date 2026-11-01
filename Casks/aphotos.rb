cask "aphotos" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "0.1.5"
  sha256 arm:          "7005e8a56deec2b147362e773e1a2b80acbbeaf0a2b831b8201f99b667a3682f",
         intel:        "3f820d7ec6fdbac7614d5c9e83c9e79fed9e735ffc46fcef7aceb7eb0a3b4041",
         arm64_linux:  "cec6b8c824ef64b9932fd450d818e927d02461c119551c00da9df5ab0f0deaf6",
         x86_64_linux: "153468a44608b4a78123753af965f70650b54b79fc76ea711743e40765bbc2b6"

  url "https://github.com/thedavidweng/amazon-photos/releases/download/v#{version}/aphotos_#{version}_#{os}_#{arch}.tar.gz"
  name "aphotos"
  desc "Unofficial Amazon Photos / Drive v1 CLI and Go SDK"
  homepage "https://github.com/thedavidweng/amazon-photos"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "aphotos"
  generate_completions_from_executable "aphotos", "completion"

  zap :not_required
end

cask "sukiru" do
  arch arm: "arm64", intel: "x86_64"

  version "1.21.0"
  sha256 arm:   "57ab43a668331a0e61d93fa07e765b06b8a68cf6db7a4c388060f3aace2fd25c",
         intel: "c819c5afcc062f811e9d24d0804b702dd3e53ee074c44a94c52399e38c9ea66d"

  url "https://github.com/thedavidweng/sukiru/releases/download/v#{version}/Sukiru-#{arch}.dmg"
  name "Sukiru"
  desc "Checks, repairs, and installs skills for coding agents"
  homepage "https://thedavidweng.github.io/sukiru/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Sukiru.app"
  binary "#{appdir}/Sukiru.app/Contents/Helpers/sukiru", target: "sukiru"

  zap trash: [
    "~/Library/Application Support/Sukiru",
    "~/Library/Saved Application State/app.sukiru.savedState",
  ]
end

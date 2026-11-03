cask "sukiru" do
  arch arm: "arm64", intel: "x86_64"

  version "1.20.0"
  sha256 arm:   "d6d976bdd0d8d9ed0983e60133b3aca57e4f3dd52561a95287485bed8eec4eda",
         intel: "ab01b58c8f2c85959087dea3b93eca75861b349ef4f42c46e7f81c16c468552a"

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

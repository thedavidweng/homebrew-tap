cask "sukiru" do
  arch arm: "arm64", intel: "x86_64"

  version "1.16.0"
  sha256 arm:   "3755587a467b4c2f072603a9ae1262a9057ff07f54b6ac29add68f372bd886b7",
         intel: "ecf6b4691ecb2a3d93d4ee79bd6869e6f257828026dd48f0c14f172350813365"

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

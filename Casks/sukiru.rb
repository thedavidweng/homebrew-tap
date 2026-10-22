cask "sukiru" do
  version "1.7.0"
  sha256 "b83cc40ac18329abeb427699be08d2df4bbd51e75890d75ebbfddb73c0673916"

  url "https://github.com/thedavidweng/sukiru/releases/download/v#{version}/Sukiru.dmg"
  name "Sukiru"
  desc "Checks, repairs, and installs skills for coding agents"
  homepage "https://thedavidweng.github.io/sukiru/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Sukiru.app"
  binary "#{appdir}/Sukiru.app/Contents/Helpers/sukiru", target: "sukiru"

  zap trash: [
    "~/Library/Application Support/Sukiru",
    "~/Library/Saved Application State/app.sukiru.savedState",
  ]
end

cask "sukiru" do
  version "1.5.2"
  sha256 "a58b6fef85d91c1e75c44ddff8ee0f12bfe547fe684c503155622e3c2311c6e3"

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

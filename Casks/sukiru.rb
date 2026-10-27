cask "sukiru" do
  arch arm: "arm64", intel: "x86_64"

  version "1.11.0"
  sha256 arm:   "daec1df2d5c45de6b8a60b960c1fbe85893e02474727cc958933c7b7293f8572",
         intel: "1ab065735c2cb519b8994dbcab35d661b91787246fb0e36b4805c52e499a6497"

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

cask "sukiru" do
  arch arm: "arm64", intel: "x86_64"

  version "1.17.0"
  sha256 arm:   "9f04bd5504f6c2329d764deae900c1412d8cbb044bd3e471bcc10c5ebf515a29",
         intel: "e337f8bc7c8651cfc9b1c140fea57bbfad203c4d4ee305da65d24756b60757b9"

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

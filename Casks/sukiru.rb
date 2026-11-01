cask "sukiru" do
  arch arm: "arm64", intel: "x86_64"

  version "1.18.0"
  sha256 arm:   "3fa492e8897cab3b84030311e9317fe43b18ba387bfc6d6eb07e5ad4d3870d64",
         intel: "5eee34eb6b553e95c90ba3eb315793ab641700a8fb1e8bcb7ee54d214a3c489c"

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

cask "canvas" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "0.5.2"
  sha256 arm:          "55043a218180978d355a6e32624c7c872a964b8d3b107177dc7ecfb058f2d5ef",
         intel:        "6623f1c98fb328ea82d9ae4ecddd7be5989973560b88ddb6cb11be60258bc147",
         arm64_linux:  "87fcaf65282ba019037d11e7f3b029f7c079984531e3c66ecda772a0349e30a3",
         x86_64_linux: "451369254a1a1706cca53dc6a919d13649f1a20b504709e9a2f1acd7201e0e2b"

  url "https://github.com/thedavidweng/canvas-cli/releases/download/v#{version}/canvas_#{version}_#{os}_#{arch}.tar.gz"
  name "canvas"
  desc "Agent-friendly CLI for Canvas LMS courses, assignments, and submissions"
  homepage "https://github.com/thedavidweng/canvas-cli"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "canvas"
  generate_completions_from_executable "canvas", "completion"

  zap :not_required
end

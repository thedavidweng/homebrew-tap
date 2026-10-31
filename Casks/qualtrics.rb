cask "qualtrics" do
  arch arm: "arm64", intel: "x86_64"

  version "0.2.4"
  sha256 arm:          "f8901a35c4748c76576071d9145509e7b4be22ab8fbb6096eb36c3b13dca01a3",
         intel:        "f8901a35c4748c76576071d9145509e7b4be22ab8fbb6096eb36c3b13dca01a3",
         arm64_linux:  "c2eb6c5ef40c246a3ccc9a3942ada9d5127360090a7856f6b622bd491d218e73",
         x86_64_linux: "ad90802a32da50913cf5c2a783f787071f25d60194d0cc8cc2d4f379cb69feda"

  on_macos do
    url "https://github.com/thedavidweng/qualtrics-cli/releases/download/v#{version}/qualtrics_darwin_universal.tar.gz"
  end
  on_linux do
    url "https://github.com/thedavidweng/qualtrics-cli/releases/download/v#{version}/qualtrics_linux_#{arch}.tar.gz"
  end

  name "qualtrics"
  desc "Agent-friendly CLI for the Qualtrics survey platform"
  homepage "https://github.com/thedavidweng/qualtrics-cli"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "qualtrics"
  generate_completions_from_executable "qualtrics", "completion",
                                       shell_parameter_format: :cobra,
                                       shells:                 [:bash, :zsh, :fish]

  postflight_steps do
    on_macos do
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{staged_path}}/qualtrics"]
    end
  end

  zap :not_required
end

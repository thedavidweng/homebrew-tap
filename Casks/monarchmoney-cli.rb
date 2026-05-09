cask "monarchmoney-cli" do
  version "0.1.4"

  on_macos do
    on_intel do
      sha256 "61bc0639ac4b821668e4975592fbc88fe6e28724a401534c80a15a22d10ab5f2"
      url "https://github.com/thedavidweng/monarchmoney-cli/releases/download/v#{version}/monarch_darwin_x86_64.tar.gz"
    end

    on_arm do
      sha256 "23e7205cd9fb971bd07da243c90e387d5f63c59199cae6a4a3df8ca2ccfa1c7e"
      url "https://github.com/thedavidweng/monarchmoney-cli/releases/download/v#{version}/monarch_darwin_arm64.tar.gz"
    end
  end

  on_linux do
    on_intel do
      sha256 "28e1f9c6269f931bb956d901d76e570d5c09dc0c91898bceaeadd5b2a8010a70"
      url "https://github.com/thedavidweng/monarchmoney-cli/releases/download/v#{version}/monarch_linux_x86_64.tar.gz"
    end

    on_arm do
      sha256 "65515ae0bd5fbe5ad563ee6eb93708bfaa53f276281aeea8bd067337c8177895"
      url "https://github.com/thedavidweng/monarchmoney-cli/releases/download/v#{version}/monarch_linux_arm64.tar.gz"
    end
  end

  name "monarchmoney-cli"
  desc "A local, agent-friendly CLI for Monarch Money."
  homepage "https://github.com/thedavidweng/monarchmoney-cli"

  livecheck do
    skip "Auto-generated on release."
  end

  binary "monarch"
end

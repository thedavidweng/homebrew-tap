cask "money" do
  version "2.0.0"

  on_macos do
    on_intel do
      sha256 "2ed23280029801aeb0e6c46cce8c5cf109beff9c152d978a1039e2759ba216d2"
      url "https://github.com/thedavidweng/money/releases/download/v#{version}/money_#{version}_darwin_amd64.tar.gz"
    end
    on_arm do
      sha256 "987a3cfc1b34e3fa6087d21c8f02e2961138cf000c15eea08696ee50d974ec65"
      url "https://github.com/thedavidweng/money/releases/download/v#{version}/money_#{version}_darwin_arm64.tar.gz"
    end
  end

  on_linux do
    on_intel do
      sha256 "3c194424e9ccbccd27c117bde9800b07bcacdd990fc4f8a662fe08aabed4d9ad"
      url "https://github.com/thedavidweng/money/releases/download/v#{version}/money_#{version}_linux_amd64.tar.gz"
    end
    on_arm do
      sha256 "acec501c008daed2514a0aad4d67ae07e8a5570d28b96371e8674898e0498386"
      url "https://github.com/thedavidweng/money/releases/download/v#{version}/money_#{version}_linux_arm64.tar.gz"
    end
  end

  name "money"
  desc "Local-first personal finance backend for agents and power users"
  homepage "https://github.com/thedavidweng/money"

  livecheck do
    skip "Auto-generated on release."
  end

  binary "money"

  # No zap stanza required
end

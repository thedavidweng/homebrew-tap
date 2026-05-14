cask "monarchmoney-cli" do
  version "0.3.1"

  on_macos do
    on_intel do
      sha256 "98be7f407828dab213040323ca99011bb82f5d83e6972ed772bd727641e29161"
      url "https://github.com/thedavidweng/monarchmoney-cli/releases/download/v#{version}/monarch_darwin_x86_64.tar.gz"
    end
    on_arm do
      sha256 "79aacd2e034d483e2c47ea71c09e18806113002c431aecd752b60e79c8c0ee7d"
      url "https://github.com/thedavidweng/monarchmoney-cli/releases/download/v#{version}/monarch_darwin_arm64.tar.gz"
    end
  end

  on_linux do
    on_intel do
      sha256 "8073404b5540cd55c0a6410e4ec8f0e3f06bac136018cdc069251b8c8e818581"
      url "https://github.com/thedavidweng/monarchmoney-cli/releases/download/v#{version}/monarch_linux_x86_64.tar.gz"
    end
    on_arm do
      sha256 "1b66f00f08888d7cfdf998a179b71b2db2bcd79a9e93118ce37511f20761e487"
      url "https://github.com/thedavidweng/monarchmoney-cli/releases/download/v#{version}/monarch_linux_arm64.tar.gz"
    end
  end

  name "monarchmoney-cli"
  desc "Local, agent-friendly CLI for Monarch Money"
  homepage "https://github.com/thedavidweng/monarchmoney-cli"

  livecheck do
    skip "Auto-generated on release."
  end

  binary "monarch"

  # No zap stanza required
end

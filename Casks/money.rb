cask "money" do
  version "0.1.0"

  on_macos do
    on_intel do
      sha256 "f72936a34e583f59832c19012f263e512532a75ca4c58453539f648b7cf38775"
      url "https://github.com/thedavidweng/money/releases/download/v#{version}/money_#{version}_darwin_amd64.tar.gz"
    end
    on_arm do
      sha256 "e45337c0ac884ffcb8682709f406d1ae33e97daf5dafbfaf61ef50ae84faceb2"
      url "https://github.com/thedavidweng/money/releases/download/v#{version}/money_#{version}_darwin_arm64.tar.gz"
    end
  end

  on_linux do
    on_intel do
      sha256 "094ae235f56cfc5ee2bfd003709039dae717555092d8c6a8c2c4643ed237d8cf"
      url "https://github.com/thedavidweng/money/releases/download/v#{version}/money_#{version}_linux_amd64.tar.gz"
    end
    on_arm do
      sha256 "6896296677ec7728be7bdf97edc5976fcd3ab54a26d11f763449ffa7b0429e65"
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

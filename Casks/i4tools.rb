cask "i4tools" do
  arch arm: "arm64", intel: "x64"

  version "9.12.015"
  sha256 arm:   "b688aa37d08f99024fcf0679cf41956f221e852bff341f0b6d13b5e535339e05",
         intel: "2efcf85a65407634627a0ee52522814411c4b9b213d45e0d39313fc9cd7a1052"

  url "https://d-updater.i4.cn/i4tools9/download/macos/#{arch}/i4Tools_v#{version}_#{arch}.dmg"
  name "爱思助手"
  name "i4Tools"
  desc "iOS device management tool"
  homepage "https://www.i4.cn/"

  livecheck do
    url "https://url.i4.cn/FFRBr2aa"
    strategy :header_match do |headers|
      headers["location"]&.match(/i4Tools[._-]v?(\d+(?:\.\d+)+)/i)&.[](1)
    end
  end

  depends_on :macos

  pkg "i4tools_#{arch}.pkg"

  uninstall pkgutil: "cn.i4Tools.mac"

  zap trash: [
    "~/Library/Caches/cn.i4Tools.mac",
    "~/Library/Preferences/cn.i4Tools.mac.plist",
    "~/Library/Saved Application State/cn.i4Tools.mac.savedState",
  ]
end

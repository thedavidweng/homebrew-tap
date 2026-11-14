cask "i4tools" do
  arch arm: "arm64", intel: "x64"

  version "9.12.019"
  sha256 arm:   "1d2f7bd7de5429d2a599b4eb29782568d82eb153c86acc406095839b4f1f209e",
         intel: "e6f74f1a60a55bb19ff0dbbb4af3635f2e4fa1cc0252543ba9d156db22c16ce6"

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

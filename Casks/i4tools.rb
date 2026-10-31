cask "i4tools" do
  arch arm: "arm64", intel: "x64"

  version "9.11.003"
  sha256 arm:   "c56bac51730878b1275e64571b889215aa04f309c421c6df3df3475846eef57d",
         intel: "40ac3980d0e19e0dfa93b7f283a37ce57e6df7d3412e9653bed3604e465320e6"

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

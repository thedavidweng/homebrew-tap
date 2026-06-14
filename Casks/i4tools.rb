cask "i4tools" do
  arch arm: "arm64", intel: "x64"

  version :latest
  sha256 :no_check

  url "https://url.i4.cn/FFRBr2aa",
      verified: "d-updater.i4.cn/"
  name "爱思助手"
  name "i4Tools"
  desc "iOS device management tool"
  homepage "https://www.i4.cn/"

  livecheck do
    url "https://url.i4.cn/FFRBr2aa"
    strategy :header_match
    regex(/i4Tools[._-]v?(\d+(?:\.\d+)+)[._-]\w+\.dmg/i)
  end

  depends_on macos: :big_sur

  pkg "i4tools_#{arch}.pkg"

  uninstall pkgutil: "cn.i4tools.mac"

  zap trash: [
    "~/Library/Caches/cn.i4Tools.mac",
    "~/Library/Preferences/cn.i4Tools.mac.plist",
    "~/Library/Saved Application State/cn.i4Tools.mac.savedState",
  ]
end

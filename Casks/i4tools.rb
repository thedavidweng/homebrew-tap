cask "i4tools" do
  arch arm: "arm64", intel: "x64"

  version "9.07.001"
  sha256 arm:   "c0a4c52ce53bff79c5ffbd64c74c07313578d1430b9421edf84d5d8592a41c45",
         intel: "443985cf6afb7b1e366b2d7e503ee3b769c8372074d1c07149c223bcb45373bd"

  url "https://d-updater.i4.cn/i4tools9/download/macos/#{arch}/i4Tools_v#{version}_#{arch}.dmg",
      verified: "d-updater.i4.cn/"
  name "爱思助手"
  name "i4Tools"
  desc "iOS device management tool"
  homepage "https://www.i4.cn/"

  livecheck do
    url "https://www.i4.cn/pros/pc.html"
    regex(/i4Tools[._-]v?(\d+(?:\.\d+)+)[._-]#{arch}\.dmg/i)
  end

  depends_on macos: :big_sur

  pkg "i4tools_#{arch}.pkg"

  uninstall pkgutil: "cn.i4tools.mac"
end

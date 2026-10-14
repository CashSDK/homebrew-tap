class Cashsdk < Formula
  desc "Manage in-app purchases, subscriptions and paywalls from your terminal"
  homepage "https://docs.cashsdk.com/cli/overview"
  license :cannot_represent # commercial, see LICENSE.md in the archive

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/CashSDK/cashsdk-cli/releases/download/v2.1.0/cashsdk_2.1.0_darwin_arm64.tar.gz"
      sha256 "f0ee5d84f6b66a94365eb57e945c111b83be3915753d85a729e15a784f2c43ba"
    else
      url "https://github.com/CashSDK/cashsdk-cli/releases/download/v2.1.0/cashsdk_2.1.0_darwin_amd64.tar.gz"
      sha256 "0cd611dab274f2a35453642eb242c74d53f236ff0d12679da159d456ceb0e5b8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/CashSDK/cashsdk-cli/releases/download/v2.1.0/cashsdk_2.1.0_linux_arm64.tar.gz"
      sha256 "93837940fcad309f55f79a9424445dbc2045bef4b815710eb2f44221d417abdc"
    else
      url "https://github.com/CashSDK/cashsdk-cli/releases/download/v2.1.0/cashsdk_2.1.0_linux_amd64.tar.gz"
      sha256 "4a909a81ed94f48904ee513ecd64507044bd4e8228a19863e8842e6a9530ba83"
    end
  end

  def install
    bin.install "cashsdk"
  end

  test do
    assert_match "cashsdk #{version}", shell_output("#{bin}/cashsdk version")
  end
end

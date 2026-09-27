class Cashsdk < Formula
  desc "Manage in-app purchases, subscriptions and paywalls from your terminal"
  homepage "https://docs.cashsdk.com/cli/overview"
  license :cannot_represent # commercial, see LICENSE.md in the archive

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/CashSDK/cashsdk-cli/releases/download/v2.0.2/cashsdk_2.0.2_darwin_arm64.tar.gz"
      sha256 "2793089e503f67b1728802703259d7b17a86368a10b007715d1ce5ffe4aedf0c"
    else
      url "https://github.com/CashSDK/cashsdk-cli/releases/download/v2.0.2/cashsdk_2.0.2_darwin_amd64.tar.gz"
      sha256 "cea12bc983308b38c31c34f4ff11b0165d118f2327639fbcf6ed0fddfe82ccc6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/CashSDK/cashsdk-cli/releases/download/v2.0.2/cashsdk_2.0.2_linux_arm64.tar.gz"
      sha256 "c34a4764423ed781949466584ce3eb4961ba3f6775669041f329019464ca4db3"
    else
      url "https://github.com/CashSDK/cashsdk-cli/releases/download/v2.0.2/cashsdk_2.0.2_linux_amd64.tar.gz"
      sha256 "7e4f77f7145e63deebfd5109bdfa73eb8c6905db406d2e6953294266e4c9800b"
    end
  end

  def install
    bin.install "cashsdk"
  end

  test do
    assert_match "cashsdk #{version}", shell_output("#{bin}/cashsdk version")
  end
end

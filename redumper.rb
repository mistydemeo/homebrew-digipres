class Redumper < Formula
  desc "Low level CD dumper utility"
  homepage "https://github.com/superg/redumper"
  # From-source build currently requires a newer clang than Apple ships
  url "https://github.com/superg/redumper/releases/download/build_438/redumper-2024.11.03_build438-Darwin.zip"
  version "438"
  sha256 "a046f7bcc79bde646a13b25888e6c794d8b7ec7aa585613ebe7093fc7433de48"
  license "GPL-3.0-only"

  # Links against a Homebrew-provided libc++
  depends_on "llvm@18"

  def install
    bin.install Dir["bin/*"]
  end

  test do
    assert_match(/build_#{version}/, shell_output("#{bin}/redumper --version"))
  end
end

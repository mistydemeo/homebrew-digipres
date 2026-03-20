class Redumper < Formula
  desc "Low level CD dumper utility"
  homepage "https://github.com/superg/redumper"
  # From-source build currently requires a newer clang than Apple ships
  url "https://github.com/superg/redumper/releases/download/b705/redumper-b705-macos-arm64.zip"
  version "705"
  sha256 "09361d7ac22e7a8734fe92b8826918f174cf4cbd2555d7556c21413bca4c3453"
  license "GPL-3.0-only"

  def install
    # Bundles a libc++ in lib, which we want to avoid making public
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/redumper"
  end

  test do
    assert_match(/build_#{version}/, shell_output("#{bin}/redumper --version"))
  end
end

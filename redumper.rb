class Redumper < Formula
  desc "Low level CD dumper utility"
  homepage "https://github.com/superg/redumper"
  # From-source build currently requires a newer clang than Apple ships
  url "https://github.com/superg/redumper/releases/download/b699/redumper-b699-macos-arm64.zip"
  version "699"
  sha256 "5f2854b52ae30613f38afaefe07a812945b126989d1eca5c0fab24b3b5ca7999"
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

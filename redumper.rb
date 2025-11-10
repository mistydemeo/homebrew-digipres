class Redumper < Formula
  desc "Low level CD dumper utility"
  homepage "https://github.com/superg/redumper"
  # From-source build currently requires a newer clang than Apple ships
  url "https://github.com/superg/redumper/releases/download/b662/redumper-b662-macos-arm64.zip"
  version "662"
  sha256 "12b33c0e2dede48b21a742a39fefe89b30fc415278a2111e92a3e4c438baf8ce"
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

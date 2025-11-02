class Redumper < Formula
  desc "Low level CD dumper utility"
  homepage "https://github.com/superg/redumper"
  # From-source build currently requires a newer clang than Apple ships
  url "https://github.com/superg/redumper/releases/download/b658/redumper-b658-macos-arm64.zip"
  version "658"
  sha256 "d8d29762d8f0944d96984b9125894514dd71ec646265d5feeff5609f9580e829"
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

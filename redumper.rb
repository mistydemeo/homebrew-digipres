class Redumper < Formula
  desc "Low level CD dumper utility"
  homepage "https://github.com/superg/redumper"
  # From-source build currently requires a newer clang than Apple ships
  url "https://github.com/superg/redumper/releases/download/build_331/redumper-2024.05.24_build331-Darwin.zip"
  version "331"
  sha256 "6d4d7436c93de9e10f75d81f95f894818699829bd216de7603cbc35ec80f4db2"
  license "GPL-3.0-only"

  def install
    # Binary dynamically links against an unspecified Homebrew-provided
    # LLVM libc++; assuming for now it's safe without it since that's
    # how it's distributed?
    bin.install Dir["bin/*"]
  end

  test do
    assert_match(/build_#{version}/, shell_output("#{bin}/redumper --version"))
  end
end

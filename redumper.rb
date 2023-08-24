class Redumper < Formula
  desc "Low level CD dumper utility"
  homepage "https://github.com/superg/redumper"
  # From-source build currently requires HEAD cmake on Mac
  url "https://github.com/superg/redumper/releases/download/build_204/redumper-2023.08.12_build204-Darwin.zip"
  version "204"
  sha256 "9d21108f78d304f7e416565e35ff528edfd60029b95df324a2a06e3af569af3d"
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

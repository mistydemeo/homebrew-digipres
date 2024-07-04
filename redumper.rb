class Redumper < Formula
  desc "Low level CD dumper utility"
  homepage "https://github.com/superg/redumper"
  # From-source build currently requires a newer clang than Apple ships
  url "https://github.com/superg/redumper/releases/download/build_385/redumper-2024.06.29_build385-Darwin.zip"
  version "385"
  sha256 "7c99c66e6435f9a46f9f91ac7eb40d2a0b0857348e750a3303600cb0eac44b2d"
  license "GPL-3.0-only"

  # Links against a Homebrew-provided libc++
  depends_on "llvm"

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

class Redumper < Formula
  desc "Low level CD dumper utility"
  homepage "https://github.com/superg/redumper"
  # From-source build currently requires a newer clang than Apple ships
  url "https://github.com/superg/redumper/releases/download/build_314/redumper-2024.02.06_build314-Darwin.zip"
  version "314"
  sha256 "03e19f94556887976f0724aec9e502727419531caae5f2e025cb15d5dced02c0"
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

class Redumper < Formula
  desc "Low level CD dumper utility"
  homepage "https://github.com/superg/redumper"
  # From-source build currently requires HEAD cmake on Mac
  url "https://github.com/superg/redumper/releases/download/build_247/redumper-2023.11.01_build247-Darwin.zip"
  version "247"
  sha256 "b93172971f812143e54d205237dbf7c76eedac09fdae5188bb1a1853086361fe"
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

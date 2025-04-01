class Redumper < Formula
  desc "Low level CD dumper utility"
  homepage "https://github.com/superg/redumper"
  # From-source build currently requires a newer clang than Apple ships
  url "https://github.com/superg/redumper/releases/download/build_537/redumper-2025.03.29_build537-Darwin64.zip"
  version "537"
  sha256 "af054396a8511ade80ec3c8b0904244bbbb4fafec39e00a3419a583f647f1aec"
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

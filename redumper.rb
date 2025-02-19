class Redumper < Formula
  desc "Low level CD dumper utility"
  homepage "https://github.com/superg/redumper"
  # From-source build currently requires a newer clang than Apple ships
  url "https://github.com/superg/redumper/releases/download/build_481/redumper-2025.02.17_build481-Darwin64.zip"
  version "481"
  sha256 "551c2a8179913fcc4d5387a4c3af80767905d54754eff3da1643ef5ac3289038"
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

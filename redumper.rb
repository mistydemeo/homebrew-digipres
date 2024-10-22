class Redumper < Formula
  desc "Low level CD dumper utility"
  homepage "https://github.com/superg/redumper"
  # From-source build currently requires a newer clang than Apple ships
  url "https://github.com/superg/redumper/releases/download/build_428/redumper-2024.10.20_build428-Darwin.zip"
  version "428"
  sha256 "49edb7023b1b11c0290fd9bc5c7cdbb68d77a41d4f123883638a84e4c016b2e3"
  license "GPL-3.0-only"

  # Links against a Homebrew-provided libc++
  depends_on "llvm"

  def install
    bin.install Dir["bin/*"]
  end

  test do
    assert_match(/build_#{version}/, shell_output("#{bin}/redumper --version"))
  end
end

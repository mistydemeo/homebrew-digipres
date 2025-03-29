class Redumper < Formula
  desc "Low level CD dumper utility"
  homepage "https://github.com/superg/redumper"
  # From-source build currently requires a newer clang than Apple ships
  url "https://github.com/superg/redumper/releases/download/build_533/redumper-2025.03.27_build533-Darwin64.zip"
  version "533"
  sha256 "b152b7a5885f2a73aebe36e3e59e43c336c9ef416c26d4d5cfe39f607a25b679"
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

class Redumper < Formula
  desc "Low level CD dumper utility"
  homepage "https://github.com/superg/redumper"
  # From-source build currently requires a newer clang than Apple ships
  url "https://github.com/superg/redumper/releases/download/build_452/redumper-2025.01.21_build452-Darwin.zip"
  version "452"
  sha256 "1f3533df49d246c6893abd553e38c58b3775fc1a9db3d077d77f99a8370a8761"
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

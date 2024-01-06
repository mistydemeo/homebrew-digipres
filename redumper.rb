class Redumper < Formula
  desc "Low level CD dumper utility"
  homepage "https://github.com/superg/redumper"
  # From-source build currently requires a newer clang than Apple ships
  url "https://github.com/superg/redumper/releases/download/build_306/redumper-2023.12.29_build306-Darwin.zip"
  version "306"
  sha256 "1df385ad2572e017d31b93adb275dce4cd5c41524fe8c6de09c9b3515e6fc3ea"
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

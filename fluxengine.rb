class Fluxengine < Formula
  desc "PSOC5 floppy disk imaging interface"
  homepage "https://github.com/davidgiven/fluxengine"
  url "https://github.com/davidgiven/fluxengine.git", revision: "d157b7b05d52ae85b7209c1d23d9a9f7f9b1df89"
  version "2022-12-12"
  license "MIT"

  depends_on "coreutils" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "libusb"
  depends_on "protobuf"
  depends_on "sqlite3"
  depends_on "zlib"

  def install
    system "make"
    bin.install "brother120tool", "brother240tool", "fluxengine"
  end

  test do
    assert_match("fluxengine: syntax", shell_output("#{bin}/fluxengine"))
  end
end

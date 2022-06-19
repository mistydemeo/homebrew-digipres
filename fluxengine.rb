class Fluxengine < Formula
  desc "PSOC5 floppy disk imaging interface"
  homepage "https://github.com/davidgiven/fluxengine"
  url "https://github.com/davidgiven/fluxengine.git", revision: "3e934a8527b723fa9fff4a98db473f4bfce393df"
  version "2022-06-17"
  license "MIT"
  head "https://github.com/davidgiven/fluxengine.git"

  depends_on "coreutils" => :build
  depends_on "make" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "fmt"
  depends_on "libusb"
  depends_on "protobuf"
  depends_on "sqlite3"
  depends_on "zlib"

  def install
    system "#{Formula["make"].opt_bin}/gmake", "fluxengine"
    bin.install "fluxengine"
  end

  test do
    assert_match("fluxengine: syntax", shell_output("#{bin}/fluxengine"))
  end
end

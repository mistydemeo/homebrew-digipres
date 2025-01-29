class FluxengineGui < Formula
  desc "PSOC5 floppy disk imaging interface"
  homepage "https://github.com/davidgiven/fluxengine"
  url "https://github.com/davidgiven/fluxengine.git", revision: "9ce405cec50ded5f64774d2448d9438a7e20b713"
  version "2024-11-24"
  license "MIT"
  head "https://github.com/davidgiven/fluxengine.git"

  # dependencies from https://github.com/davidgiven/fluxengine/blob/master/.github/workflows/release.yml
  depends_on "sqlite3"
  depends_on "pkg-config" => :build
  depends_on "libusb"
  depends_on "protobuf"
  depends_on "wxwidgets"
  depends_on "fmt"
  depends_on "make" => :build
  depends_on "coreutils" => :build
  depends_on "dylibbundler"
  depends_on "libjpeg"

  def install
    system "#{Formula["make"].opt_bin}/gmake", "fluxengine-gui"
    bin.install "fluxengine-gui"
  end
end

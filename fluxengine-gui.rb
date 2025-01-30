class FluxengineGui < Formula
  version "2024-11-24"
  desc "PSOC5 floppy disk imaging interface"
  homepage "https://github.com/davidgiven/fluxengine"
  license "MIT"

  url "https://github.com/davidgiven/fluxengine.git", revision: "9ce405cec50ded5f64774d2448d9438a7e20b713"

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

  # Necessary to build just the .app file
  patch do
    url "https://github.com/davidgiven/fluxengine/pull/800/commits/d4c1dfee59045a062658c4b1070d77a660d2d378.patch?full_index=1"
    sha256 "a9bb2ee4afbba1bba81ffdb803c50bbcc50b3344986f9fd81c96b8802f96f126"
  end

  def install
    # the build shells out to brew to copy licenses over, we replicate that here
    system "sed", "-i", "-E", "/.*brew --prefix.*/d", "src/gui/build.py"
    system "gmake", "FluxEngine.app"

    # copy the licenses
    cp "#{Formula["wxwidgets"].opt_prefix}/README.md", "FluxEngine.app/Contents/libs/wxWidgets.md"
    cp "#{Formula["protobuf"].opt_prefix}/LICENSE", "FluxEngine.app/Contents/libs/protobuf.md"
    cp "#{Formula["fmt"].opt_prefix}/LICENSE", "FluxEngine.app/Contents/libs/fmt.md"
    cp "#{Formula["libpng"].opt_prefix}/LICENSE", "FluxEngine.app/Contents/libs/libpng.md"
    cp "#{Formula["libjpeg"].opt_prefix}/README", "FluxEngine.app/Contents/libs/libjpeg.md"
    cp "#{Formula["abseil"].opt_prefix}/LICENSE", "FluxEngine.app/Contents/libs/abseil.md"
    cp "#{Formula["libtiff"].opt_prefix}/LICENSE.md", "FluxEngine.app/Contents/libs/libtiff.md"
    cp "#{Formula["zstd"].opt_prefix}/LICENSE", "FluxEngine.app/Contents/libs/zstd.md"

    prefix.install "FluxEngine.app"
  end
end

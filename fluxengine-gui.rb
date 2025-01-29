cask FluxengineGui do
  name "FluxEngine Gui"
  desc "PSOC5 floppy disk imaging interface"
  homepage "https://github.com/davidgiven/fluxengine"
  version "2024-11-24"
  license "MIT"
  head "https://github.com/davidgiven/fluxengine.git"
  app "FluxEngine.app"

  head do
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
      system "#{Formula["make"].opt_bin}/gmake", "fluxengine-gui"
      bin.install "fluxengine-gui"
    end
  end
end

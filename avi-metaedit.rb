class AviMetaedit < Formula
  homepage "https://github.com/usnationalarchives/AVI-MetaEdit"
  url "https://github.com/mistydemeo/AVI-MetaEdit/tarball/1.0.0"
  sha256 "cfc2d135a4b58108fdf0de9f8ba3b581e5c9f5a50fa891e87c745d3b8bd46af6"

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    cd "Project/GNU/CLI" do
      # autogen is missing a shebang
      system "/bin/sh", "autogen"

      system "./configure", "--disable-debug", "--disable-dependency-tracking",
                            "--prefix=#{prefix}"
      system "make", "install"
    end
  end

  def test
    system "#{bin}/avimetaedit"
  end
end

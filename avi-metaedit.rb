require 'formula'

class AviMetaedit < Formula
  homepage 'https://github.com/usnationalarchives/AVI-MetaEdit'
  url 'https://github.com/mistydemeo/AVI-MetaEdit/tarball/1.0.0'
  sha1 'fe6024f6c6efb4804ea42aa699d8076544c5f0b4'

  depends_on :autoconf
  depends_on :automake

  def install
    cd "Project/GNU/CLI" do
      # autogen is missing a shebang
      system "/bin/sh", "autogen"

      system "./configure", "--disable-debug", "--disable-dependency-tracking",
                            "--prefix=#{prefix}"
      system "make install"
    end
  end

  def test
    system "#{bin}/avimetaedit"
  end
end

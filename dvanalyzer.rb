class Dvanalyzer < Formula
  homepage "http://www.avpreserve.com/dvanalyzer/"
  url "http://download.mediaarea.net/binary/dvanalyzer/1.4.1/AVPS_DV_Analyzer_CLI_1.4.1_GNU_FromSource.tar.bz2"
  version "1.4.1"
  sha256 "36531b67c37c530dbb2ddcd0ab0a5bcf075f202a97ee25b3a020ddcae7ba33e9"

  def install
    system "./CLI_Compile.sh"
    cd "AVPS_DV_Analyzer/Project/GNU/CLI" do
      system "./configure", "--prefix=#{prefix}"
      system "make", "install"
    end
  end

  def test
    system "#{bin}/dvanalyzer", "--help"
  end
end

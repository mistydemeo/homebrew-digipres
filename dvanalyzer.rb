require 'formula'

class Dvanalyzer < Formula
  homepage 'http://www.avpreserve.com/dvanalyzer/'
  url 'http://download.mediaarea.net/binary/dvanalyzer/1.4.1/AVPS_DV_Analyzer_CLI_1.4.1_GNU_FromSource.tar.bz2'
  version '1.4.1'
  sha1 'd065aa7f01e4b2ec7feebf4e10f58b5a7dbbbc4f'

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

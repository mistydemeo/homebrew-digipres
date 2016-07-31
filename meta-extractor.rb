class MetaExtractor < Formula
  homepage "http://meta-extractor.sourceforge.net/"
  url "http://downloads.sourceforge.net/project/meta-extractor/meta-extractor/3.5GA/meta-extractor-bin-3-5GA.tar.gz"
  version "3.5GA"
  sha256 "600383a58ddec94ad45902638328f01db086eef054cf1d52679d41b949e152ad"

  def install
    %w[metadata.sh extract.sh].each do |file|
      inreplace file do |s|
        # yeah, Windows line endings in a bash script :(
        s.gsub! /\r\n/, "\n"
        s.gsub! "$JAVA_HOME", "/usr"
        s.gsub! '$(cd -P -- "$(dirname -- "$0")" && pwd -P)', libexec
      end
    end

    bin.install "extract.sh" => "extract"
    bin.install "metadata.sh" => "metadata"
    libexec.install Dir['*']
  end

  def test
    system "#{bin}/extract"
  end
end

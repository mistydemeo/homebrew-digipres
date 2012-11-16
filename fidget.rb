require 'formula'

class Fidget < Formula
  homepage 'https://github.com/openplanets/format-corpus'
  url 'https://github.com/downloads/openplanets/format-corpus/fidget-0.0.1-SNAPSHOT-bin-unix.tar.gz'
  version '0.0.1-snapshot'
  sha1 '70302dcaf1cdcc45c89b2ebe872108e318ae435c'

  def install
    bin.install "bin/fidget"
    lib.install Dir['lib/*']
  end

  def test
    system "#{bin}/fidget --help"
  end
end

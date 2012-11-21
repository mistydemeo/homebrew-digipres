require 'formula'

class Fidget < Formula
  homepage 'https://github.com/openplanets/format-corpus'
  url 'https://github.com/downloads/openplanets/format-corpus/fidget-0.0.3-SNAPSHOT-bin-unix.tar.gz'
  version '0.0.3-snapshot'
  sha1 '5f9d397307ca45fcf4fac9494d5380a47cd79f06'

  def install
    inreplace "bin/fidget" do |s|
      s.change_make_var! "BASEDIR", libexec
    end
    bin.install "bin/fidget"
    (libexec/"lib").install Dir['lib/*']
  end

  def test
    system "#{bin}/fidget --help"
  end
end

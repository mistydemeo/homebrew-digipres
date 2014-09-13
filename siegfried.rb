require 'formula'

class Siegfried < Formula
  homepage 'http://www.itforarchivists.com/siegfried'
  url 'https://github.com/richardlehane/siegfried/releases/download/v0.4.1/siegfried_0-4-1_darwin64.zip'
  sha1 '5f9d397307ca45fcf4fac9494d5380a47cd79f06'

  def install
    bin.install "bin/sieg"
  end

  def test
    system "#{bin}/sieg -update"
  end
end

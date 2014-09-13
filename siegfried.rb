require 'formula'

class Siegfried < Formula
  homepage 'http://www.itforarchivists.com/siegfried'
  url 'https://github.com/richardlehane/siegfried/releases/download/v0.4.1/siegfried_0-4-1_darwin64.zip'
  version '0.4.1'
  sha1 '8017bb067ab3a887afb193f52e43cbd1142c3c36'

  def install
    bin.install "sieg"
  end

  def test
    system "#{bin}/sieg -update"
  end
end

require 'formula'

class Fido < Formula
  homepage 'https://github.com/openplanets/fido'
  url 'https://github.com/openplanets/fido/archive/1.3.1-77.tar.gz'
  sha1 'a40b0c3d0a3db0585f5344db7f8276935324f9a6'
  version "1.3.1-77"

  head 'https://github.com/openplanets/fido.git'

  def install
    libexec.install Dir['fido/*']
    %w[fido.py prepare.py pronomutils.py toxml.py update_signatures.py].each do |f|
      (bin/f.gsub('.py', '')).write <<-EOS.undent
      #!/bin/sh
      exec python "#{libexec}/#{f}" "$@"
      EOS
    end
  end

  def test
    system "#{bin}/fido", "-v"
  end
end

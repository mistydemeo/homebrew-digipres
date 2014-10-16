require 'formula'

class Fido < Formula
  homepage 'https://github.com/openplanets/fido'
  url 'https://github.com/openplanets/fido/archive/1.3.1-78.tar.gz'
  sha1 '0122a48d122c6d01af5a9f39b03f3bddc35250d3'
  version "1.3.1-78"

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

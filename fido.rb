class Fido < Formula
  homepage "https://github.com/openplanets/fido"
  url "https://github.com/openplanets/fido/archive/1.3.1-78.tar.gz"
  sha256 "f8955faa1234c7e1f399892433ace1fd055cee883e1ab2a0d0ed98461c08c765"
  version "1.3.1-78"

  head "https://github.com/openplanets/fido.git"

  def install
    libexec.install Dir["fido/*"]
    %w[fido.py prepare.py pronomutils.py toxml.py update_signatures.py].each do |f|
      (bin/f.gsub(".py", "")).write <<-EOS.undent
      #!/bin/sh
      exec python "#{libexec}/#{f}" "$@"
      EOS
    end
  end

  def test
    system "#{bin}/fido", "-v"
  end
end

class Fidget < Formula
  homepage "https://github.com/openplanets/format-corpus"
  url "https://github.com/downloads/openplanets/format-corpus/fidget-0.0.3-SNAPSHOT-bin-unix.tar.gz"
  version "0.0.3-snapshot"
  sha256 "f118a2a204e0f2ed9a9df139614c1dc9973724e8eddee910a12008cfa214051a"

  def install
    inreplace "bin/fidget" do |s|
      s.change_make_var! "BASEDIR", libexec
    end
    bin.install "bin/fidget"
    (libexec/"lib").install Dir["lib/*"]
  end

  def test
    system "#{bin}/fidget --help"
  end
end

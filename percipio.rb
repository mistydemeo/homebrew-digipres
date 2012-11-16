require 'formula'

class Percipio < Formula
  homepage 'https://github.com/anjackson/percipio'
  url 'https://github.com/downloads/anjackson/percipio/percipio.jar',
    :using => :nounzip
  version '0.0.2-snapshot'
  sha1 '0a730beb2f7510f08f93f4f007da13228d5a1a2e'

  def install
    libexec.install "percipio.jar"
    (bin/"percipio").write <<-EOS.undent
    #!/bin/sh
    java -jar #{libexec}/percipio.jar
    EOS
  end

  def test
    system "#{bin}/percipio"
  end
end

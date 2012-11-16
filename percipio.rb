require 'formula'

class Percipio < Formula
  homepage 'https://github.com/anjackson/percipio'
  url 'https://github.com/downloads/anjackson/percipio/percipio.jar',
    :using => :nounzip
  version '0.0.2-snapshot'
  sha1 '0a730beb2f7510f08f93f4f007da13228d5a1a2e'

  def install
    libexec.install "percipio.jar"
    bin.write_jar_script libexec/"percipio.jar", "percipio"
  end

  def test
    system "#{bin}/percipio"
  end
end

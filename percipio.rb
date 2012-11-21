require 'formula'

class Percipio < Formula
  homepage 'https://github.com/anjackson/percipio'
  url 'https://github.com/downloads/anjackson/percipio/percipio-0.0.2-SNAPSHOT-jar-with-dependencies.jar',
    :using => :nounzip
  version '0.0.2-snapshot-20121116'
  sha1 '4f463728867fb330c68ec8d1b6428821812f8124'

  def install
    libexec.install "percipio-0.0.2-SNAPSHOT-jar-with-dependencies.jar" => "percipio.jar"
    bin.write_jar_script libexec/"percipio.jar", "percipio"
  end

  def test
    system "#{bin}/percipio"
  end
end

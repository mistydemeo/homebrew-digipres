class Percipio < Formula
  homepage "https://github.com/anjackson/percipio"
  url "https://github.com/downloads/anjackson/percipio/percipio-0.0.2-SNAPSHOT-jar-with-dependencies.jar",
    :using => :nounzip
  version "0.0.2-snapshot-20121116"
  sha256 "8df3fdd01cfb549ed97e979ee86e94846d36ef38511859e5b363ccab1ff3fc7c"

  def install
    libexec.install "percipio-0.0.2-SNAPSHOT-jar-with-dependencies.jar" => "percipio.jar"
    bin.write_jar_script libexec/"percipio.jar", "percipio"
  end

  def test
    system "#{bin}/percipio"
  end
end

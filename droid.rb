require 'formula'

class Droid < Formula
  homepage 'http://digital-preservation.github.com/droid/'
  url 'http://www.nationalarchives.gov.uk/documents/information-management/droid-binary-6.1.2-bin.zip'
  sha1 '3501e41b404caa30c74d298fd8ce9ad382141f81'

  def install
    libexec.install Dir['*.jar']
    libexec.install "lib"
    inreplace "droid.sh" do |s|
      s.gsub! "droid-command-line-6.1.2.jar", "#{libexec}/droid-command-line-6.1.2.jar"
      s.gsub! "droid-ui-6.1.2.jar", "#{libexec}/droid-ui-6.1.2.jar"
    end
    bin.install "droid.sh" => "droid"
  end

  def test
    system "#{bin}/droid", "-gt", "0"
  end
end

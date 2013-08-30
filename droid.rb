require 'formula'

class Droid < Formula
  homepage 'http://digital-preservation.github.com/droid/'
  url 'http://www.nationalarchives.gov.uk/documents/information-management/droid-binary-6.1.3-bin.zip'
  sha1 '88ddc08d7386e75291d9c5ecb0e43391e7c7b984'

  def install
    libexec.install Dir['*.jar']
    libexec.install "lib"
    inreplace "droid.sh" do |s|
      s.gsub! "droid-command-line-6.1.3.jar", "#{libexec}/droid-command-line-6.1.3.jar"
      s.gsub! "droid-ui-6.1.3.jar", "#{libexec}/droid-ui-6.1.3.jar"
    end
    bin.install "droid.sh" => "droid"
  end

  def test
    system "#{bin}/droid", "--version"
  end
end

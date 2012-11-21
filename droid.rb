require 'formula'

class Droid < Formula
  homepage 'http://digital-preservation.github.com/droid/'
  url 'https://github.com/downloads/digital-preservation/droid/droid-binary-6.1-bin.zip'
  sha1 '4db9eba7acd39a0dd90700a81847de83b00acdcb'

  def install
    libexec.install Dir['*.jar']
    libexec.install "lib"
    inreplace "droid.sh" do |s|
      s.gsub! "droid-command-line-6.1.jar", "#{libexec}/droid-command-line-6.1.jar"
      s.gsub! "droid-ui-6.1.jar", "#{libexec}/droid-ui-6.1.jar"
    end
    bin.install "droid.sh" => "droid"
  end

  def test
    system "#{bin}/droid", "-gt", "0"
  end
end

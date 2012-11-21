require 'formula'

class Droid < Formula
  homepage 'http://droid.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/droid/droid/6.0/droid-6.01.zip'
  version '6.01'
  sha1 '5a2038060a56a159edd2b771d4744aea7ee1444a'

  def install
    libexec.install Dir['*.jar']
    libexec.install "lib"
    inreplace "droid.sh" do |s|
      s.gsub! "droid-command-line-6.0.jar", "#{libexec}/droid-command-line-6.0.jar"
      s.gsub! "droid-ui-6.0.jar", "#{libexec}/droid-ui-6.0.jar"
    end
    bin.install "droid.sh" => "droid"
  end

  def test
    system "#{bin}/droid", "-gt", "0"
  end
end

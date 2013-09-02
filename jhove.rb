require 'formula'

class Jhove < Formula
  homepage 'http://jhove.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/jhove/jhove/JHOVE%201.10/jhove-1_10.tar.gz'
  version '1.10'
  sha1 '3902e6b61d6ab5edf5dac4d9e5673d6560a53a9b'

  def install
    inreplace "conf/jhove.conf", "/users/stephen/projects/jhove", libexec
    inreplace "jhove.tmpl" do |s|
      s.change_make_var! "JHOVE_HOME", libexec
      s.change_make_var! "JAVA_HOME", "/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home"
      s.gsub! "${JHOVE_HOME}/bin/", "${JHOVE_HOME}/"
    end

    bin.install "jhove.tmpl" => "jhove"
    libexec.install Dir['bin/*.jar']
    libexec.install "conf"
  end

  def test
    system "#{bin}/jhove"
  end
end

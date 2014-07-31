require 'formula'

class Jhove < Formula
  homepage 'http://jhove.sourceforge.net/'
  url 'https://downloads.sourceforge.net/project/jhove/jhove/JHOVE%201.11/jhove-1_11.tar.gz'
  sha1 'acc5aae97017bdb2206197dc952ae47ee6555f6f'

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

  test do
    system "#{bin}/jhove"
  end
end

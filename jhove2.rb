require 'formula'

class Jhove2 < Formula
  homepage 'https://bitbucket.org/jhove2/main/wiki/Home'
  url 'http://bitbucket.org/jhove2/main/downloads/jhove2-2.1.0.tar.gz'
  sha1 'f0159a536e4e3b6a56aa08a63cf9a0f5a3834ff0'

  def install
    inreplace 'jhove2.sh' do |s|
      s.change_make_var! 'ProgDir', libexec
    end
    libexec.install Dir['*']
    (bin/'jhove2').make_relative_symlink libexec/'jhove2.sh'
  end

  test do
    system "false"
  end
end

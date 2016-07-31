class Jhove2 < Formula
  homepage "https://bitbucket.org/jhove2/main/wiki/Home"
  url "http://bitbucket.org/jhove2/main/downloads/jhove2-2.1.0.tar.gz"
  sha256 "d5036b76775b4c25d38c611f523010d65e426a70c809a04e7059b113ccd92087"

  def install
    inreplace "jhove2.sh" do |s|
      s.change_make_var! "ProgDir", libexec
    end
    libexec.install Dir["*"]
    (bin/"jhove2").make_relative_symlink libexec/"jhove2.sh"
  end
end

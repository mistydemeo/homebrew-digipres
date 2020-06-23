class Hfdisk < Formula
  desc "Classic Mac disk partitioning tool"
  homepage "http://www.codesrc.com/gitweb/index.cgi?p=hfdisk.git;a=summary"
  head "git://www.codesrc.com/git/hfdisk.git"

  def install
    system "make"
    bin.install "hfdisk"
    man8.install "hfdisk.8"
  end

  test do
    assert_equal(shell_output("#{bin}/hfdisk --version"), "version 1.0-rc3 (28 May 2014)\n")
  end
end

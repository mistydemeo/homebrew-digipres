#
# Some inspiration taken from here:
# https://github.com/mxcl/homebrew/blob/master/Library/Formula/jruby.rb
#
# Awkward as JWAT-Tools relies on an additional helper script to set up the
# classpath. Will look at simplifying this.
#

class Jwattools < Formula
  homepage "https://sbforge.org/display/JWAT/JWAT-Tools"
  url "https://bitbucket.org/nclarkekb/jwat-tools/downloads/jwat-tools-0.5.6-SNAPSHOT.zip"
  version "0.5.6-SNAPSHOT"
  sha256 "36949ed3e80313b258d9ac4ced000177b70a0c35fb44343600c6c13fb52865d5"

  def install
    mv "jwattools.sh", "jwattools"
    libexec.install Dir['*']
    bin.install_symlink "#{libexec}/jwattools"
    bin.install_symlink "#{libexec}/env.sh"
  end

  test do
    # Simple test that checks that the classpath loading worked correctly.
    system "#{bin}/jwattools", "help", "test"
  end
end

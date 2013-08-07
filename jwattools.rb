require 'formula'

#
# Some inspiration taken from here:
# https://github.com/mxcl/homebrew/blob/master/Library/Formula/jruby.rb
#
# Awkward as JWAT-Tools relies on an additional helper script to set up the 
# classpath. Will look at simplifying this.
# 

class Jwattools < Formula
  homepage 'https://sbforge.org/display/JWAT/JWAT-Tools'
  url 'https://bitbucket.org/nclarkekb/jwat-tools/downloads/jwat-tools-0.5.6-SNAPSHOT.zip'
  version '0.5.6-SNAPSHOT'
  sha1 'bd639ba1d22ef6fc01f20dddafd19a8fbe5fd84b'

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

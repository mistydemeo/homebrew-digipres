require "formula"

class Droid < Formula
  homepage "http://digital-preservation.github.com/droid/"
  url "http://www.nationalarchives.gov.uk/documents/information-management/droid-binary-6.1.5-bin.zip"
  sha1 "ee9144ba720dfb5ac7578b6289e133fcd9f86d17"

  def install
    libexec.install Dir["*.jar"]
    libexec.install "lib"
    inreplace "droid.sh" do |s|
      s.gsub! "droid-command-line-6.1.5.jar", "#{libexec}/droid-command-line-6.1.5.jar"
      s.gsub! "droid-ui-6.1.5.jar", "#{libexec}/droid-ui-6.1.5.jar"
    end
    bin.install "droid.sh" => "droid"
  end

  def test
    system "#{bin}/droid", "--version"
  end
end

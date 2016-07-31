class Droid < Formula
  desc "Java-based PRONOM file identification tool"
  homepage "http://digital-preservation.github.com/droid/"
  url "http://nationalarchives.gov.uk/documents/information-management/droid-binary-6.2.1-bin.zip"
  sha256 "45d8928f1425c1c0fbc0f8fb3dea9f07a0fe6848d0dd4696e15da1c52152d627"

  def install
    libexec.install Dir["*.jar"]
    libexec.install "lib"
    inreplace "droid.sh" do |s|
      s.gsub! "droid-command-line-6.2.1.jar", "#{libexec}/droid-command-line-6.2.1.jar"
      s.gsub! "droid-ui-6.2.1.jar", "#{libexec}/droid-ui-6.2.1.jar"
    end
    bin.install "droid.sh" => "droid"
  end

  def test
    system "#{bin}/droid", "--version"
  end
end

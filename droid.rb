class Droid < Formula
  desc "Java-based PRONOM file identification tool"
  homepage "http://digital-preservation.github.com/droid/"
  url "http://www.nationalarchives.gov.uk/documents/information-management/droid-binary-6.4-bin.zip"
  sha256 "9dd6289c1f03d8a9d628ab0127954e05acf4aa2f5f7d606b8a1b78996a98b815"

  def install
    libexec.install Dir["*.jar"]
    libexec.install "lib"
    inreplace "droid.sh" do |s|
      s.gsub! "$DROID_HOME/droid-command-line-6.4.jar", "#{libexec}/droid-command-line-6.4.jar"
      s.gsub! "$DROID_HOME/droid-ui-6.4.jar", "#{libexec}/droid-ui-6.4.jar"
    end
    bin.install "droid.sh" => "droid"
  end

  test do
    assert_equal "6.4", shell_output("#{bin}/droid --version").chomp
  end
end

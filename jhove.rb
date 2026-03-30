class Jhove < Formula
  homepage "http://jhove.openpreservation.org/"
  url "https://github.com/openpreserve/jhove/archive/v1.14.6.tar.gz"
  sha256 "516f22ab75d9d68ad12d5726b28d9dbc9364b69052e24c33c7ff9d62f82b7e4f"

  depends_on "maven"

  def install
    inreplace "jhove-installer/src/main/scripts/jhove.tmpl" do |s|
      s.change_make_var! "JHOVE_HOME", libexec
      s.change_make_var! "JAVA_HOME", "/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home"
      s.change_make_var! "CP", "${JHOVE_HOME}/jhove-apps-1.14.0.jar:${EXTRA_JARS}"
    end
    
    system 'mvn', 'package'

    bin.install "jhove-installer/src/main/scripts/jhove.tmpl" => "jhove"
    libexec.install Dir["jhove-installer/target/staging/bin/*.jar"]
  end

  test do
    system "#{bin}/jhove"
  end
end

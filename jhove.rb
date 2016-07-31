class Jhove < Formula
  homepage "http://jhove.openpreservation.org/"
  url "https://github.com/openpreserve/jhove/releases/download/v1.11/jhove-1_11.tar.gz"
  sha256 "c8099da227f5c48da8b45c41b0528054fbb9dd7545c33dd5bbf19c31281df614"

  def install
    inreplace "conf/jhove.conf", "/users/stephen/projects/jhove", libexec
    inreplace "jhove.tmpl" do |s|
      s.change_make_var! "JHOVE_HOME", libexec
      s.change_make_var! "JAVA_HOME", "/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home"
      s.gsub! "${JHOVE_HOME}/bin/", "${JHOVE_HOME}/"
    end

    bin.install "jhove.tmpl" => "jhove"
    libexec.install Dir["bin/*.jar"]
    libexec.install "conf"
  end

  test do
    system "#{bin}/jhove"
  end
end

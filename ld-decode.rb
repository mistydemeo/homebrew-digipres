require "language/python"

class LdDecode < Formula
  include Language::Python::Virtualenv

  desc "Software defined LaserDisc decoder"
  homepage "https://github.com/happycube/ld-decode"
  url "https://github.com/happycube/ld-decode/archive/rev6.tar.gz"
  version "6.0"
  sha256 "9a861020ae50bf9ad6a4da2cf61d33e6b4f03ec8790308b45d6b9b0667671095"
  head "https://github.com/happycube/ld-decode.git"

  depends_on "ffmpeg"
  depends_on "fftw"
  depends_on "llvm@8" # newest version supported by llvmlite
  depends_on "numpy"
  depends_on "openssl@1.1"
  depends_on "python@3.8"
  depends_on "qt"
  depends_on "qwt"
  depends_on "scipy"

  # matplotlib
  resource "cycler" do
    url "https://files.pythonhosted.org/packages/c2/4b/137dea450d6e1e3d474e1d873cd1d4f7d3beed7e0dc973b06e8e10d32488/cycler-0.10.0.tar.gz"
    sha256 "cd7b2d1018258d7247a71425e9f26463dfb444d411c39569972f4ce586b0c9d8"
  end

  # matplotlib
  resource "kiwisolver" do
    url "https://files.pythonhosted.org/packages/62/b8/db619d97819afb52a3ff5ff6ad3f7de408cc83a8ec2dfb31a1731c0a97c2/kiwisolver-1.2.0.tar.gz"
    sha256 "247800260cd38160c362d211dcaf4ed0f7816afb5efe56544748b21d6ad6d17f"
  end

  # matplotlib
  resource "pyparsing" do
    url "https://files.pythonhosted.org/packages/c1/47/dfc9c342c9842bbe0036c7f763d2d6686bcf5eb1808ba3e170afdb282210/pyparsing-2.4.7.tar.gz"
    sha256 "c203ec8783bf771a155b207279b9bccb8dea02d8f0c9e5f8ead507bc3246ecc1"
  end

  # matplotlib
  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/be/ed/5bbc91f03fa4c839c4c7360375da77f9659af5f7086b7a7bdda65771c8e0/python-dateutil-2.8.1.tar.gz"
    sha256 "73ebfe9dbf22e832286dafa60473e4cd239f8592f699aa5adaf10050e6e1823c"
  end

  # matplotlib
  resource "six" do
    url "https://files.pythonhosted.org/packages/21/9f/b251f7f8a76dec1d6651be194dfba8fb8d7781d10ab3987190de8391d08e/six-1.14.0.tar.gz"
    sha256 "236bdbdce46e6e6a3d61a337c0f8b763ca1e8717c03b369e87a7ec7ce1319c0a"
  end

  # numba
  resource "llvmlite" do
    url "https://files.pythonhosted.org/packages/50/cc/04526507e80d546be5688ce0246e40277b61e7949c3347c6609b6a4154cf/llvmlite-0.32.1.tar.gz"
    sha256 "41262a47b8cbba5a09203b15b65fbdf11192f92aa226c81e99115acdee8f3b8d"
  end

  resource "matplotlib" do
    url "https://files.pythonhosted.org/packages/4a/30/eb8e7dd8e3609f05c6920fa82f189302c832e5a0f6667aa96f952056bc0c/matplotlib-3.2.1.tar.gz"
    sha256 "ffe2f9cdcea1086fc414e82f42271ecf1976700b8edd16ca9d376189c6d93aee"
  end

  resource "numba" do
    url "https://files.pythonhosted.org/packages/a8/23/d56b70e79c18c34c1787bf2cda957f821790ec7ccd35a1962d5be102d572/numba-0.49.1.tar.gz"
    sha256 "89e1ad8215918036b0ffc53501888d44ed44c1f2cb09a9e047d06af5cd7e7a5a"
  end

  resource "pandas" do
    url "https://files.pythonhosted.org/packages/2f/79/f236ab1cfde94bac03d7b58f3f2ab0b1cc71d6a8bda3b25ce370a9fe4ab1/pandas-1.0.3.tar.gz"
    sha256 "32f42e322fb903d0e189a4c10b75ba70d90958cc4f66a1781ed027f1a1d14586"
  end

  def install
    virtualenv_install_with_resources

    if build.stable?
      inreplace "Makefile" do |s|
        # Makefile authoring error
        # https://github.com/happycube/ld-decode/commit/af61091ce0232d43e4b1d1f16e55467a738484ca#diff-b67911656ef5d18c4ae36cb6741b7965
        s.gsub! "TARGETS=cx", "TARGETS="
        # prefix was added in a post-6.0 release
        s.gsub! "/usr/local/bin", bin.to_s
      end

      Dir["tools/**/*.pro"].each do |f|
        inreplace f, "/usr/local/bin", bin.to_s
      end
    end

    bin.mkpath
    system "make", "prefix=#{prefix}"
    system "make", "install", "prefix=#{prefix}"

    # These two app bundles shouldn't go in bin.
    prefix.install "#{bin}/ld-analyse.app"
    prefix.install "#{bin}/ld-process-efm.app"
  end

  test do
    system "#{bin}/ld-decode", "-h"
  end
end

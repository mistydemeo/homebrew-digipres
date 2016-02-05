require "language/go"
require "yaml"

class Siegfried < Formula
  desc "Fast PRONOM-based file identification tool"
  homepage "http://www.itforarchivists.com/siegfried"
  url "https://github.com/richardlehane/siegfried/archive/v1.4.5.tar.gz"
  sha256 "7d32f523e2697f32fc3e9e8d61d3174e26edb86280ef26bbc1d09a930382c8c7"
  head "https://github.com/richardlehane/siegfried.git", :branch => "develop"

  depends_on "go" => :build

  def install
    # Avoid installing signature files into the user's home directory;
    # install them into share instead.
    inreplace "config/brew.go", "/usr/share/siegfried", share/"siegfried"

    mkdir_p buildpath/"src/github.com/richardlehane"
    ln_s buildpath, buildpath/"src/github.com/richardlehane/siegfried"

    # Dependencies are vendored
    ENV["GO15VENDOREXPERIMENT"] = "1"
    ENV["GOPATH"] = buildpath

    system "go", "build", "-tags", "brew",
                 "github.com/richardlehane/siegfried/cmd/sf"
    system "go", "build", "-tags", "brew",
                 "github.com/richardlehane/siegfried/cmd/roy"

    bin.install "sf", "roy"
    (share/"siegfried").install Dir["src/github.com/richardlehane/siegfried/cmd/roy/data/*"]
  end

  test do
    results = YAML.load_documents `"#{bin}/sf" "#{test_fixtures("test.jpg")}"`
    assert_equal version.to_s, results[0]["siegfried"]
    assert_equal "fmt/43", results[1]["matches"][0]["puid"]
  end
end

require "formula"
require "language/go"
require "yaml"

class Siegfried < Formula
  homepage "http://www.itforarchivists.com/siegfried"
  url "https://github.com/richardlehane/siegfried/archive/v0.8.3.tar.gz"
  sha1 "4ceed2844bf18760805948429771b334801680ea"

  depends_on "go" => :build

  go_resource "github.com/richardlehane/match" do
    url "https://github.com/richardlehane/match.git",
      :revision => "786a5a13b1bf9f4757385d2efa3e5c5f16122569"
  end

  go_resource "github.com/richardlehane/mscfb" do
    url "https://github.com/richardlehane/mscfb.git",
      :revision => "38b6a8d3da3c578ba4b337e7ed5beba601469776"
  end

  go_resource "github.com/richardlehane/msoleps" do
    url "https://github.com/richardlehane/msoleps.git",
      :revision => "b0830452f54a0c927d81dd529ee6da770218fee8"
  end

  go_resource "golang.org/x/sys" do
    url "https://github.com/golang/sys.git",
      :revision => "28779c6daddbd86e5286abf21ad66ad9b02de278"
  end

  def install
    # Avoid installing signature files into the user's home directory;
    # install them into share instead.
    inreplace "config/brew.go", "/usr/share/siegfried", share/"siegfried"

    (buildpath/"src/github.com/richardlehane/siegfried").install Dir["*"]
    Language::Go.stage_deps resources, buildpath/"src"
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

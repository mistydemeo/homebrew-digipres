require "formula"
require "language/go"
require "yaml"

class Siegfried < Formula
  homepage "http://www.itforarchivists.com/siegfried"
  url "https://github.com/richardlehane/siegfried/archive/v1.0.0.tar.gz"
  sha256 "4ccb5fddc064c1d74cceef39a202f34e9e01413e582bd03efae42403b4ef7bbc"

  depends_on "go" => :build

  go_resource "github.com/richardlehane/match" do
    url "https://github.com/richardlehane/match.git",
      :revision => "77bb91e49e7ec76ea836473745c056eac3a83693"
  end

  go_resource "github.com/richardlehane/mscfb" do
    url "https://github.com/richardlehane/mscfb.git",
      :revision => "d3597948314fdb42844fa389eb3becd01cc8a17f"
  end

  go_resource "github.com/richardlehane/msoleps" do
    url "https://github.com/richardlehane/msoleps.git",
      :revision => "b0830452f54a0c927d81dd529ee6da770218fee8"
  end

  go_resource "golang.org/x/sys" do
    url "https://github.com/golang/sys.git",
      :revision => "8642817a1a1d69c31059535024a5c3f02b5b176f"
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

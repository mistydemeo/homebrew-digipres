require "formula"
require "language/go"
require "yaml"

class Siegfried < Formula
  homepage "http://www.itforarchivists.com/siegfried"
  url "https://github.com/richardlehane/siegfried/archive/v1.4.1.tar.gz"
  sha256 "e0534903e33fc2cdd79d5e943a91a39eae1673df53aee90f8a2ce58712117691"

  depends_on "go" => :build

  go_resource "github.com/richardlehane/match" do
    url "https://github.com/richardlehane/match.git",
      :revision => "c3f128223aaa58ba0430d706e31834955c1073e6"
  end

  go_resource "github.com/richardlehane/characterize" do
    url "https://github.com/richardlehane/characterize.git",
      :revision => "65ae777baca4bd03ec6457d4bf014a700fd0dd06"
  end

  go_resource "github.com/richardlehane/mscfb" do
    url "https://github.com/richardlehane/mscfb.git",
      :revision => "9c05c69abf63aec04cc637dcb82eb56fddd46250"
  end

  go_resource "github.com/richardlehane/msoleps" do
    url "https://github.com/richardlehane/msoleps.git",
      :revision => "4cd1b2f6d92e7c429fcedeff31a40bc0532ed96c"
  end

  go_resource "github.com/richardlehane/webarchive" do
    url "https://github.com/richardlehane/webarchive.git",
      :revision => "f5489060c21bbdcd5f50fe733b14797de989bdf0"
  end

  go_resource "golang.org/x/sys" do
    url "https://github.com/golang/sys.git",
      :revision => "d9157a9621b69ad1d8d77a1933590c416593f24f"
  end

  go_resource "golang.org/x/text" do
    url "https://github.com/golang/text.git",
      :revision => "4b139bd6df30da3409365d90f851848508cdb48b"
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

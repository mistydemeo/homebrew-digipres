require "language/go"
require "yaml"

class Siegfried < Formula
  desc "Fast PRONOM-based file identification tool"
  homepage "http://www.itforarchivists.com/siegfried"
  url "https://github.com/richardlehane/siegfried/archive/v1.4.3.tar.gz"
  sha256 "1e6f9cb4a5125e82760f9aefe95b21663abf901c51dab0b59334c84f8f6b8367"
  head "https://github.com/richardlehane/siegfried.git", :branch => "develop"

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
      :revision => "104e4a4bd3638684d631003b2a3665902234f2bf"
  end

  go_resource "github.com/richardlehane/msoleps" do
    url "https://github.com/richardlehane/msoleps.git",
      :revision => "4cd1b2f6d92e7c429fcedeff31a40bc0532ed96c"
  end

  go_resource "github.com/richardlehane/webarchive" do
    url "https://github.com/richardlehane/webarchive.git",
      :revision => "10a81c7ffea1bf70a2500daae57d74fbc4e7a747"
  end

  go_resource "golang.org/x/sys" do
    url "https://github.com/golang/sys.git",
      :revision => "833a04a10549a95dc34458c195cbad61bbb6cb4d"
  end

  go_resource "golang.org/x/text" do
    url "https://github.com/golang/text.git",
      :revision => "cf4986612c83df6c55578ba198316d1684a9a287"
  end

  def install
    # Avoid installing signature files into the user's home directory;
    # install them into share instead.
    inreplace "config/brew.go", "/usr/share/siegfried", share/"siegfried"

    (buildpath/"src/github.com/richardlehane/siegfried").install Dir["*"]
    # HEAD uses vendored dependencies and doesn't require staging godeps
    Language::Go.stage_deps resources, buildpath/"src" if build.stable?

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

require "formula"
require "language/go"

class Siegfried < Formula
  homepage "http://www.itforarchivists.com/siegfried"
  url "https://github.com/richardlehane/siegfried/archive/v0.6.0.tar.gz"
  sha1 "2ec3c4281adbf6668eca109cb49d02329201b0cb"

  depends_on "go" => :build

  go_resource "github.com/richardlehane/match" do
    url "https://github.com/richardlehane/match.git",
      :revision => "dbc5ddc0ef24256ecd0af8d8bbc850de452af25d"
  end

  go_resource "github.com/richardlehane/mscfb" do
    url "https://github.com/richardlehane/mscfb.git",
      :revision => "aef15fee14dd01bd5bb6022e2e665fad7aa6beb7"
  end

  go_resource "github.com/richardlehane/msoleps" do
    url "https://github.com/richardlehane/msoleps.git",
      :revision => "c496257da4daf0de7e91d200c01cb5490138151c"
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

    bin.install "sf"
    (share/"siegfried").install Dir["src/github.com/richardlehane/siegfried/cmd/r2d2/data/*"]
  end

  test do
    system "#{bin}/sf", "--version"
  end
end

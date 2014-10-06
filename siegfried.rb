require "formula"
require "language/go"

class Siegfried < Formula
  homepage "http://www.itforarchivists.com/siegfried"
  url "https://github.com/richardlehane/siegfried/archive/v0.5.0.tar.gz"
  sha1 "60dc6a1338451dca309e95637fa34ae68c963679"

  depends_on "go" => :build

  go_resource "github.com/richardlehane/match" do
    url "https://github.com/richardlehane/match.git",
      :revision => "dbc5ddc0ef24256ecd0af8d8bbc850de452af25d"
  end

  go_resource "github.com/richardlehane/mscfb" do
    url "https://github.com/richardlehane/mscfb.git",
      :revision => "b34882c7c3a53496ef355824887a91e9877f8442"
  end

  go_resource "github.com/richardlehane/msoleps" do
    url "https://github.com/richardlehane/msoleps.git",
      :revision => "c496257da4daf0de7e91d200c01cb5490138151c"
  end

  def install
    (buildpath/"src/github.com/richardlehane/siegfried").install Dir["*"]
    Language::Go.stage_deps resources, buildpath/"src"
    ENV["GOPATH"] = buildpath

    # Avoid installing signature files into the user's home directory;
    # install them into share instead.
    inreplace "src/github.com/richardlehane/siegfried/cmd/sf/sf.go" do |s|
      s.gsub! 'filepath.Join(current.HomeDir, ".siegfried"',
        %{filepath.Join("#{share}", "siegfried"}
      s.gsub! "current, err := user.Current()", "_, err := user.Current()"
    end

    system "go", "build", "github.com/richardlehane/siegfried/cmd/sf"

    bin.install "sf"
    (share/"siegfried").install Dir["src/github.com/richardlehane/siegfried/cmd/r2d2/data/*"]
  end

  test do
    system "#{bin}/sf", "--version"
  end
end

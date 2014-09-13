require "formula"
require "language/go"

class Siegfried < Formula
  homepage "http://www.itforarchivists.com/siegfried"
  url "https://github.com/richardlehane/siegfried/archive/v0.4.1.tar.gz"
  sha1 "7e0b8f479cedf41580d152532ce37277394c6f90"

  depends_on "go" => :build

  go_resource "github.com/richardlehane/match" do
    url "https://github.com/richardlehane/match.git",
      :revision => "2e2742c915158c9d189c17da7e80ca95f350b530"
  end

  def install
    (buildpath/"src/github.com/richardlehane/siegfried").install Dir["*"]
    Language::Go.stage_deps resources, buildpath/"src"
    ENV["GOPATH"] = buildpath

    # Avoid installing signature files into the user's home directory;
    # install them into share instead.
    inreplace "src/github.com/richardlehane/siegfried/cmd/sieg/sieg.go" do |s|
      s.gsub! 'filepath.Join(current.HomeDir, ".siegfried"',
        %{filepath.Join("#{share}", "siegfried"}
      s.gsub! "current, err := user.Current()", "_, err := user.Current()"
    end

    system "go", "build", "github.com/richardlehane/siegfried/cmd/sieg"

    bin.install "sieg"
    (share/"siegfried").install Dir["src/github.com/richardlehane/siegfried/cmd/r2d2/data/*"]
  end

  test do
    system "#{bin}/sieg", "--version"
  end
end

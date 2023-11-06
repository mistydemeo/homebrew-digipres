class DiscImageCreator < Formula
  desc "Low-level optical disc archiving tool"
  homepage "https://github.com/saramibreak/DiscImageCreator"
  url "https://github.com/saramibreak/DiscImageCreator/files/12565312/DiscImageCreator_20230909.tar.gz"
  sha256 "224c0f12f179d1b5055edba296e96a91e335a1f823e33bf6441415a43d3b97ab"
  license "Apache-2.0"

  def install
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"DiscImageCreator"
  end

  test do
    assert_match /#{version}/, shell_output("#{bin}/DiscImageCreator /v")
  end
end

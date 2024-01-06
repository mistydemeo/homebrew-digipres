class DiscImageCreator < Formula
  desc "Low-level optical disc archiving tool"
  homepage "https://github.com/saramibreak/DiscImageCreator"
  url "https://github.com/saramibreak/DiscImageCreator/files/13801554/DiscImageCreator_20240101.tar.gz"
  sha256 "ea06cfd06dcf968746a38598812867ae6fd9356fb0f58612717c8df4d3336781"
  license "Apache-2.0"

  def install
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"DiscImageCreator"
  end

  test do
    assert_match /#{version}/, shell_output("#{bin}/DiscImageCreator /v")
  end
end

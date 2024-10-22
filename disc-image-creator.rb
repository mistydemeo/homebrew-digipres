class DiscImageCreator < Formula
  desc "Low-level optical disc archiving tool"
  homepage "https://github.com/saramibreak/DiscImageCreator"
  url "https://github.com/user-attachments/files/17211442/DiscImageCreator_20241001.zip"
  sha256 "8bec694331f9faa546880631d3f675d92d56b5f27d4bfcb1252656b0c31db953"
  license "Apache-2.0"

  def install
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"DiscImageCreator"
  end

  test do
    assert_match /#{version}/, shell_output("#{bin}/DiscImageCreator /v")
  end
end

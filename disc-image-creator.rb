class DiscImageCreator < Formula
  desc "Low-level optical disc archiving tool"
  homepage "https://github.com/saramibreak/DiscImageCreator"
  url "https://github.com/saramibreak/DiscImageCreator/files/13527858/DiscImageCreator_20231201.tar.gz"
  sha256 "79bfc714d54f0a3815f55f787ea57fd524cd73e62ee3e0d813f053b9d17f94c0"
  license "Apache-2.0"

  def install
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"DiscImageCreator"
  end

  test do
    assert_match /#{version}/, shell_output("#{bin}/DiscImageCreator /v")
  end
end

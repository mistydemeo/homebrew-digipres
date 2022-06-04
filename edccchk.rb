class Edccchk < Formula
  desc "EDC/ECC checker for RAW (2352 bytes/sector) CD images"
  homepage "https://github.com/claunia/edccchk"
  url "https://github.com/claunia/edccchk/archive/refs/tags/v1.27.tar.gz"
  sha256 "6546ea1b760541d71acb1c9b8042a168c9088249b4cdd2f854c63aaaf658f629"
  license "GPL-3.0-only"

  # Necessary to build with clang
  # https://github.com/claunia/edccchk/pull/2
  patch do
    url "https://github.com/claunia/edccchk/commit/199a6f910de370581aa7a87ad5d0cbde53a1eb7f.patch?full_index=1"
    sha256 "df42f6e6b51a14a46eb0ebc74d9a14d4a832ef44e96cb355025a2a81ffb2e5ec"
  end

  def install
    system "make"
    bin.install "edccchk"
  end

  test do
    # Produce a 2352-byte pseudo disc image
    (testpath/"data.img").open("w") do |f|
      data = ([0] * 294).pack("C*")
      8.times do
        f.write(data)
      end
    end

    assert_match("Non-data sectors........ 1", shell_output("#{bin}/edccchk #{testpath}/data.img"))
  end
end

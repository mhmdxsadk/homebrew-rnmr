class rnmr < Formula
  desc "Lightweight command-line tool for renaming files and directories"
  homepage "https://github.com/mhmdxsadk/rnmr"
  url "https://github.com/mhmdxsadk/homebrew-rnmr/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "1d86c17734ee954f994d529b5e00ee8587a9d834a58db3380f0743fc4214af9b"
  license "MIT"

  def install
    bin.install "rnmr.py" => "rnmr"
  end

  test do
    (testpath/"x.txt").write("content")
    system "#{bin}/rnmr", "x.txt", "y.txt"
    assert_predicate testpath/"y.txt", :exist?
    assert_equal "content", (testpath/"y.txt").read.strip
  end
end

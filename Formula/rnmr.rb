class Rnmr < Formula
  desc "Lightweight command-line tool for renaming files and directories"
  homepage "https://github.com/mhmdxsadk/rnmr"
  url "https://github.com/mhmdxsadk/homebrew-rnmr/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "1a4b45f584e4e243127e4b166b755aa902b645e087f90b359e3cbec915db46c6"
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

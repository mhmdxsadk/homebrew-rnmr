class Rnmr < Formula
  desc "Lightweight command-line tool for renaming files and directories"
  homepage "https://github.com/mhmdxsadk/rnmr"
  url "https://github.com/mhmdxsadk/homebrew-rnmr/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "1d86c17734ee954f994d529b5e00ee8587a9d834a58db3380f0743fc4214af9b"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    # Test renaming a file: x.txt -> y.txt
    (testpath/"x.txt").write("content")
    system "#{bin}/rnmr", "x.txt", "y.txt"
    assert_predicate testpath/"y.txt", :exist?
    assert_equal "content", (testpath/"y.txt").read.strip
  
    # Clean up files to avoid overwrite errors
    (testpath/"x.txt").delete if (testpath/"x.txt").exist?
    (testpath/"y.txt").delete if (testpath/"y.txt").exist?
  
    # Test renaming when the destination file already exists: x.txt and y.txt -> error
    (testpath/"x.txt").write("new content")
    (testpath/"y.txt").write("existing content")
    output = shell_output("#{bin}/rnmr x.txt y.txt 2>&1", 1)
    assert_match "Output path 'y.txt' already exists.", output
    assert_equal "existing content", (testpath/"y.txt").read.strip
  
    # Clean up directories if they exist
    (testpath/"x").rmtree if (testpath/"x").exist?
    (testpath/"y").rmtree if (testpath/"y").exist?
  
    # Test renaming a directory: x/ -> y/
    mkdir testpath/"x"
    system "#{bin}/rnmr", "x", "y"
    assert_predicate testpath/"y", :directory?
  
    # Clean up directories
    (testpath/"x").rmtree if (testpath/"x").exist?
    (testpath/"y").rmtree if (testpath/"y").exist?
  
    # Test renaming when the destination directory already exists: x/ y/ -> error
    mkdir testpath/"x"
    mkdir testpath/"y"
    output = shell_output("#{bin}/rnmr x y 2>&1", nil)
    assert_match "Output path 'y.txt' already exists.", output
  end
end

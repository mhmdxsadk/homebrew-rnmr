class Rnmr < Formula
  desc "Lightweight command-line tool for renaming files and directories"
  homepage "https://github.com/moealkurdi/rnmr"
  url "https://github.com/moealkurdi/homebrew-rnmr/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "178f476ba5d91f91976413540f8c272c0962ec4df465674a76e99cdd38f47167"
  license "MIT"

  def install
    bin.install "rnmr.py" => "rnmr"
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

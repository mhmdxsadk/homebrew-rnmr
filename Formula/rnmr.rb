class Rnmr < Formula
  include Language::Python::Virtualenv

  desc "Lightweight command-line tool for renaming files and directories"
  homepage "https://github.com/mhmdxsadk/homebrew-rnmr"
  url "https://github.com/mhmdxsadk/homebrew-rnmr/archive/refs/tags/v1.0.5.tar.gz"
  sha256 "a9799cdcf31ec4cd770d201ff01717cc04919c68f6efdfe0b2e5e67b938bf544"
  license "MIT"

  depends_on "python@3.12"

  resource "click" do
    url "https://files.pythonhosted.org/packages/source/c/click/click-8.1.7.tar.gz"
    sha256 "ca9853ad459e787e2192211578cc907e7594e294c7ccc834310722b41b9ca6de"
  end

  resource "colorama" do
    url "https://files.pythonhosted.org/packages/source/c/colorama/colorama-0.4.6.tar.gz"
    sha256 "08695f5cb7ed6e0531a20572697297273c47b8cae5a63ffc6d6ed5c201be6e44"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    (testpath/"x.txt").write("content")
    system "#{bin}/rnmr", "x.txt", "y.txt"
    assert_predicate testpath/"y.txt", :exist?
    assert_equal "content", (testpath/"y.txt").read.strip
  end
end
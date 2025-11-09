class Rnmr < Formula
  include Language::Python::Virtualenv

  desc "Lightweight command-line tool for renaming files and directories"
  homepage "https://github.com/mhmdxsadk/homebrew-rnmr"
  url "https://github.com/mhmdxsadk/homebrew-rnmr/archive/refs/tags/v1.0.4.tar.gz"
  sha256 "81579a4265fd7d56675f0f94fc31f668cb1d251c55b23048bc935ca2c8c7fd3d"
  license "MIT"

  depends_on "python@3.9"

  resource "click" do
    url "https://files.pythonhosted.org/packages/py3/c/click/click-8.1.7.tar.gz"
    sha256 "ca9853ad28de1ce219aab4a3b0287a34cbf194ab86f8e4e9dcebc9f7ed2e8f6e"
  end

  resource "colorama" do
    url "https://files.pythonhosted.org/packages/py3/c/colorama/colorama-0.4.6.tar.gz"
    sha256 "08695f5cb7ed6a8a1e22d2b6e6e3e0c3b77d2e3a8bbf78f8c0f3f75f31a6f0b8"
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
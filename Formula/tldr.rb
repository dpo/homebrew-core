class Tldr < Formula
  desc "Simplified and community-driven man pages"
  homepage "https://tldr-pages.github.io"
  url "https://github.com/tldr-pages/tldr-cpp-client/archive/v1.3.0.tar.gz"
  sha256 "6210ece3f5d8f8e55b404e2f6c84be50bfdde9f0d194a271bce751a3ed6141be"
  revision 1
  head "https://github.com/tldr-pages/tldr-cpp-client.git"

  bottle do
    cellar :any
    sha256 "5ff44173bde5f458335b89ba3e4f4c9a1d917dc3f0f4059477d82d91e079f691" => :sierra
    sha256 "f8b2e7e60cc4ff8c212914f5bcf4b7d413ae7a69e095c6ce29ce79010d6354b5" => :el_capitan
    sha256 "376962a72d11da559d25aabb3d22f7b2105e21809c58d09597ab312b3685719a" => :yosemite
    sha256 "5ae13d00538b944c8ba9fe23b28eb5e907590237844cf77106ada9b8b107a0fc" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "libzip"
  depends_on "curl" unless OS.mac?

  def install
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    assert_match "brew", shell_output("#{bin}/tldr brew")
  end
end

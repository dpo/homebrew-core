class Pdnsrec < Formula
  desc "Non-authoritative/recursing DNS server"
  homepage "https://www.powerdns.com/recursor.html"
  url "https://downloads.powerdns.com/releases/pdns-recursor-4.0.6.tar.bz2"
  sha256 "f2182ac644268bb08b865a71351f11d75c5015ac0608a1469eb4c1cd5494d60d"

  bottle do
    sha256 "cc9312578fb77bed4d92725ccec1a49d40a5113743117aff240d7a7021ca015c" => :sierra
    sha256 "bd074b480630fc4dab01fe3886c2430dc3617aec6e34d6e68cc8cec84ffaebe7" => :el_capitan
    sha256 "efe5c4b834cb36612741b353c4705fda3510f42f8ee09265b4077373e7a05669" => :yosemite
    sha256 "23c44f0b24643b6f0778e3eb67d77bc30d0eb87e276d7feb980171026e8a0319" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "openssl"
  depends_on "lua"
  depends_on "gcc" if OS.mac? && DevelopmentTools.clang_build_version <= 600

  needs :cxx11

  fails_with :clang do
    build 600
    cause "incomplete C++11 support"
  end

  def install
    # Reduce memory usage below 4 GB for Circle CI.
    ENV["MAKEFLAGS"] = "-j4" if ENV["CIRCLECI"]

    ENV.cxx11

    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}/powerdns
      --disable-silent-rules
      --with-boost=#{Formula["boost"].opt_prefix}
      --with-openssl=#{Formula["openssl"].opt_prefix}
      --with-lua
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    output = shell_output("#{sbin}/pdns_recursor --version 2>&1")
    assert_match "PowerDNS Recursor #{version}", output
  end
end

class Miniupnpd < Formula
  desc "An implementation of a UPnP IGD + NAT-PMP / PCP gateway"
  homepage "https://miniupnp.tuxfamily.org"
  url "http://miniupnp.tuxfamily.org/files/download.php?file=miniupnpd-2.0.tar.gz"
  sha256 "d96aa3a00e0f5490826bba3cb97e68cd27479e5839adac4b9bcb66eae786bfb7"

  def install
    system "./genconfig.sh"
    args = %W[
      INCLUDES=-I/Users/jeff/local/src/xnu-kernel.git/bsd:-I/Users/jeff/local/src/xnu-kernel.git/libkern
      PREFIX=#{prefix}
    ]

    system *args, "make -f Makefile.macosx"
    # system "make -f Makefile.macosx install"
  end
end


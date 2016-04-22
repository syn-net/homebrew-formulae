class Minissdpd < Formula
  desc "SSDP managing daemon; works with miniupnpc, miniupnpd, minidlna, etc."
  homepage "https://miniupnp.tuxfamily.org"
  url "https://miniupnp.tuxfamily.org/files/download.php?file=minissdpd-1.5.tar.gz"
  sha256 "dfd637b185731e1acb412a86faa9718eb93c04ca08280541a6d22d14d1fb890f"

  def install
    system "make", "INSTALLPREFIX=#{prefix}", "install"
  end
end


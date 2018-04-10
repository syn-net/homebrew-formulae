require 'formula'

class Acpica < Formula
  homepage 'https://www.acpica.org/'
  url 'https://acpica.org/sites/acpica/files/acpica-unix2-20140424.tar.gz'
  sha256 '72ece982bbbdfb1b17418f1feb3a9daaa01803d0d41dcf00e19d702cdf751bbc'

  head 'https://github.com/acpica/acpica.git'

  def install
    ENV.deparallelize
    system "make", "HOST=_APPLE", "PREFIX=#{prefix}"
    system "make", "install", "HOST=_APPLE", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/iasl -h"
  end
end

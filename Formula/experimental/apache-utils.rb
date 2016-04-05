# 2012-03/18:jeff
#
# => apache-utils.rb
#
# Apache Utils; port of Debian's a2enmod, a2dismod, a2ensite & a2dissite tools
# for use on Mac OSX v10.7.3 Apache2 hosts
#
# =>    REFERENCES
#

require 'formula'

class ApacheUtils < Formula

  # official site is offline as of this moment
  url 'http://anonscm.debian.org/viewvc/pkg-apache/trunk/apache2/'

  homepage 'http://www.debian.org'

  def install

    args = [
      "--prefix=#{prefix}",
      "--sysconfdir=#{etc}"
    ]

    system "./configure", *args
    system 'make'

    # ...TODO

  end

  def test
  	system 'true'
  end

  def caveats; <<-EOS
  end
end

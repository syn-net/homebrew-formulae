# 2012-03/15:jeff
#
# => mod_suphp.rb
#
# mod_suPHP module
#
# =>    REFERENCES
#
# => 1. http://techtrunch.com/installations/compile-apache-suphp-ubuntu#more-1236
# => 2. http://blog.stuartherbert.com/php/2008/01/18/using-suphp-to-secure-a-shared-server/
# => 3. http://www.chrisam.net/blog/2009/10/11/installing-and-configuring-suphp-on-centos-5-3/
# => 4.
#

require 'formula'

class ModSuphp < Formula

  # official site is offline as of this moment
  url 'ftp://mirrors.kernel.org/ubuntu/pool/universe/s/suphp/suphp_0.7.1.orig.tar.gz'
  version '0.7.1'
  homepage 'http://www.suphp.org'
  md5 'dc41fb75b93595d6663c444c3ddd9e1d'

  def install

    args = [
      "--prefix=#{prefix}",
      "--sysconfdir=#{etc}",
      "--with-min-uid=70",
      "--with-min-gid=70",
      "--with-logfile=/private/var/log/apache2/suphp_log",
      "--disable-debug",
      "--disable-checkpath",
      "--with-apache-user=_www", # As per Mac OS X v10.7.3, Apache v2.2
      "--with-setid-mode=paranoid",
      "--with-apxs=/usr/sbin/apxs",
      "--with-apr=/usr" # path to libapr1-dev build system / apr-config
    ]

    system "./configure", *args
    system 'make'

    libexec.install ['src/apache2/.libs/mod_suphp.0.0.0.so', 'src/apache2/.libs/mod_suphp.so']
    #libexec.install Dir['src/apache2/.libs/*']
    bin.install ['src/suphp']
    etc.install ['doc/suphp.conf-example']
    doc.install ['doc/CONFIG', 'doc/INSTALL', 'doc/LICENSE', 'doc/README']
    doc.install Dir['apache/*']
  end

  def test
  	system 'true'
  end

  def caveats; <<-EOS
To enable mod_suPHP in Apache add the following to httpd.conf:
    LoadModule mod_suphp    #{libexec}/mod_suphp.so

    AddType application/x-httpd-php   .php
    AddHandler application/x-httpd-php .php

An example configuration script has been copied in place to #{etc}/suphp.conf-example
and must be setup first. Rename it to #{etc}/suphp.conf once you are satisfied.

Documentation has been installed at #{doc}. Do not forget to restart Apache when all
is said and done! :-)
   EOS
  end
end

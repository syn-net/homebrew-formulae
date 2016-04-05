require 'formula'

class ModFastcgi < Formula
  url 'http://www.fastcgi.com/dist/mod_fastcgi-current.tar.gz'
  homepage 'http://www.fastcgi.com/'
  md5 'a21a613dd5dacf4c8ad88c8550294fed'
  version '2.4.6'

	def install
 		system "apxs -o mod_fastcgi.so -c *.c"
 		#system "apxs -i -n fastcgi mod_fastcgi.so"

 		libexec.install ['.libs/mod_fastcgi.so']
 		doc.install Dir['docs/*']
 		doc.install ['CHANGES', 'INSTALL', 'INSTALL.AP2', 'README']
  end
end

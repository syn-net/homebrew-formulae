# 2012-03/15:jeff
#
#		GTKMan
#
# Graphical interface for manual pages
#

require 'formula'

class Gtkman < Formula

	url 'https://salix.svn.sourceforge.net/svnroot/salix/gtkman'
	version '20120315'
	homepage 'http://www.salixos.org/wiki/index.php/GTKMan'
	#md5 ''

	depends_on 'python', 'pygtk'

  	def install
	    system "cd trunk && ./compile.sh"
	    system "DESTDIR=#{prefix} ./install.sh"
	end

	def test
		system "true"
	end
end

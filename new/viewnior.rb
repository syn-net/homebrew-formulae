# 2012-03/19:jeff
#
#		viewnior.rb
#
# Homebrew Formulae
#

require 'formula'

class Viewnior < Formula
	url "git://github.com/xsisqox/Viewnior.git"
	homepage "http://xsisqox.github.com/Viewnior/"
	#md5 ''
	version '2012.03.19'

	#depends_on 'perl'
	depends_on 'glib'
	depends_on 'gtk+'
	depends_on 'shared-mime-info'
	depends_on 'gnome-common'

	system "perl -MCPAN -e 'install XML::Parser'" # Deps: XML::Parser

  #def options
  #	[
  #		['--enable-wallpaper', 'Enables Image -> Desktop Background feature']
  #	]
  #end

  def install
  	#args.push "--disable-wallpaper" unless ARGV.include? '--enable-wallpaper'

 		args = [
     	"--prefix=#{prefix}",
     	"--disable-debug",
     	"--disable-wallpaper"
   	]

    #
    # TODO/FIXME: http://wiki.panotools.org/Hugin_Compiling_OSX
    #
    # =>  export LIBTOOLIZE=glibtoolize
    #
   	system "./autogen.sh"
  	system "./configure", *args
  	system "make"
  	system "make install"
	end

  def test
  	system "true"
  end
end

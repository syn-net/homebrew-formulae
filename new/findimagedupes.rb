# 2012-03/19:jeff
#
#		findimagedupes.rb
#
# Homebrew Formulae
#

require 'formula'

class Findimagedupes < Formula
  url "http://www.jhnc.org/findimagedupes/findimagedupes-2.18.tar.gz"
  homepage "http://www.jhnc.org/findimagedupes/"
  md5 '5c353c6e4611e194114d4192c32c6adb'
  version '2.18'

  # Whereas the below following Perl dependencies compile without a hitch on the
  # system-wide version of Perl (v5.14.2 / OSX v10.7.3), we cannot install them
  # as it requires super-user privileges.
  #   As I'm not sure nor all that interested in finding out how to "properly"
  # get around this side issue ...I offer my slightly modified Perl brew package
  # as the "temporary" solution.
  #
  # In other words: it's forever resolved as far as I'm concerned!
  # (Until it's not!) :-D
  #
  #depends_on 'perl'
  depends_on 'graphicsmagick'

	def install
    system "perl -MCPAN -e 'install Inline'" # depends_on 'Inline.pm'
    system "perl -MCPAN -e 'install File::MimeInfo'" # depends_on 'File::MimeInfo'
    system "perl -MCPAN -e 'Install File::MimeInfo::Magic'

    bin.install ['findimagedupes']
 		doc.install ['README', 'COPYING', 'history', 'findimagedupes.html']
  end

  def test
  	system "true"
  end
end

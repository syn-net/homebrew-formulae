# 2012-07/14:jeff
#
# =>        cantata.rb
#
# Homebrew formula for the Cantata MPD client
#
# =>        NOTES
#
# 1. svn checkout http://cantata.googlecode.com/svn/trunk/ cantata-read-only
#

require 'formula'

class Cantata < Formula
  url 'http://cantata.googlecode.com/files/cantata-0.7.1.tar.bz2'
  homepage 'http://code.google.com/p/cantata/'
  md5 'd1043d2834617dbefb76658c0bfd67ca'
  #version '0.7.1'

  depends_on 'cmake' => :build
  depends_on 'libmtp'
  depends_on 'mpg123'
  depends_on 'qt'
  depends_on 'taglib'
  #depends_on 'taglib-extras'

  def install
    cmake_args = std_cmake_args
    cmake_args << "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    cmake_args << "-DWANT_KDE_SUPPORT=NO"
    cmake_args << "."

    system "cmake", *cmake_args
    system "make install"

    doc.install ['AUTHORS', 'ChangeLog', 'INSTALL', 'LICENSE', 'README', 'TODO']
  end

  def test
    system "true" # TODO
  end
end

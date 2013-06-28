# 2012-07/14:jeff
#
# =>        taglib-extras.rb
#
# Homebrew formula for the taglib-extras package
#

require 'formula'

class TaglibExtras < Formula
  url 'http://www.kollide.net/~jefferai/taglib-extras-1.0.1.tar.gz'
  homepage 'http://taglib.github.com/'
  md5 'e973ca609b18e2c03c147ff9fd9e6eb8'
  #version '1.0.1'

  depends_on 'cmake' => :build
  depends_on 'taglib'

  def install
    cmake_args = std_cmake_args
    cmake_args << "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    cmake_args << "."

    system "cmake", *cmake_args
    system "make install"

    doc.install ['AUTHORS', 'COPYING.LGPL', 'ChangeLog']
  end

  def test
    system "true" # TODO
  end
end

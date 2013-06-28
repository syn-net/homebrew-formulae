require 'formula'

class Colortail < Formula
  url 'https://github.com/joakim666/colortail/zipball/master'
  homepage 'http://joakimandersson.se/projects/colortail/'
  version '0.3'
  md5 '14c41d224c0042ec0f8bfc005185f2c0'

  def install
    system "sh autogen.sh"
	system "./configure --disable-debug --disable-dependency-tracking --prefix=#{prefix}"
    system "make install"
  end
end

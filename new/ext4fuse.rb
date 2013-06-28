require 'formula'

class Ext4fuse < Formula
  url 'https://github.com/gerard/ext4fuse/zipball/master'
  version 'git-20120714'
  homepage 'https://github.com/gerard/ext4fuse'

  depends_on 'pkg-config'
  depends_on 'fuse4x'

  def install
    system 'make'
    system "make install"
  end

  def test
    # This test will fail and we won't accept that! It's enough to just
    # replace "false" with the main program this formula installs, but
    # it'd be nice if you were more thorough. Test the test with
    # `brew test ext4fuse`. Remove this comment before submitting
    # your pull request!
  	system 'ext4fuse'
  end

  def patches
  	DATA
  end
end

__END__
--- Makefile    2011-11-29 08:28:12.000000000 -0600
+++ patches/Makefile    2011-11-29 08:32:44.000000000 -0600
@@ -2,6 +2,8 @@
 $(error You need to install pkg-config in order to compile this sources)
 endif

+PREFIX=/usr/local
+
 CFLAGS  += $(shell pkg-config fuse --cflags) -DFUSE_USE_VERSION=26 -std=gnu99 -g3 -Wall -Wextra
 LDFLAGS += $(shell pkg-config fuse --libs)

@@ -13,7 +15,7 @@
 endif

 ifeq ($(shell uname), FreeBSD)
-CFLAGS  += -I/usr/local/include -L/usr/local/lib
+CFLAGS  += -I${PREFIX}/include -L${PREFIX}/lib
 LDFLAGS += -lexecinfo
 endif

@@ -34,4 +36,10 @@
 rm -f *.o $(BINARY)
 rm -rf test/logs

+install:
+	install ext4fuse ${PREFIX}/bin
+
+#uninstall:
+	#rm -rf ${PREFIX}/bin/ext4fuse
+
 .PHONY: test

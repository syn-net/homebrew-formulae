# 2012-07/16:jeff
#
# =>        gimp.rb
#
# Homebrew formula for GIMP 2.8.x development series
#
# =>        NOTES
#
# 1. https://github.com/Frizlab/homebrew/commit/f563e1604a693f3b2d4fb9740457a808d81f12f8
# 2. https://raw.github.com/Frizlab/homebrew/f563e1604a693f3b2d4fb9740457a808d81f12f8/Library/Formula/gimp.rb
#
require 'formula'

class Gimp < Formula
  url 'ftp://ftp.gimp.org/pub/gimp/v2.8/gimp-2.8.0.tar.bz2'
  homepage 'http://www.gimp.org/'
  md5 '28997d14055f15db063eb92e1c8a7ebb'
# There are currently no public devel versions of Gimp
#  devel do
#    url 'ftp://ftp.gimp.org/pub/gimp/v2.9/gimp-2.8.0-RC1.tar.bz2'
#    md5 '134396e4399b7e753ffca7ba366c418f'
#  end

  depends_on 'atk'
  depends_on 'gtk+'
  depends_on 'babl'
  depends_on 'gegl'
  depends_on 'glib'
  depends_on 'pango'
  depends_on 'cairo'
  depends_on 'gettext'
  depends_on 'intltool'
  depends_on 'gdk-pixbuf'

  depends_on 'dbus-glib' => :optional

  depends_on 'libart' => :optional
  depends_on 'hicolor-icon-theme' => :optional

  depends_on 'pkg-config' => :build

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking", "--prefix=#{prefix}",
                          "--enable-mp", "--with-pdbgen", "--with-x",
                          "--x-includes=/usr/X11R6/include", "--x-libraries=/usr/X11R6/lib",
                          "--without-hal", "--without-alsa", "--without-gvfs", "--without-webkit",
                          "--enable-python", "--disable-dbus"

    system "make install"

    # Let's optimze the Gimp icons loading if gtk-update-icon-cache is installed.
    gtk_update_icon_cache_path = "#{HOMEBREW_PREFIX}/bin/gtk-update-icon-cache"
    system "test -x #{gtk_update_icon_cache_path} && #{gtk_update_icon_cache_path} -f -t #{HOMEBREW_PREFIX}/share/icons/hicolor || ! test -x #{gtk_update_icon_cache_path}"
  end
end

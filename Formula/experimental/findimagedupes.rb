require 'formula'

class Findimagedupes < Formula
  url "http://www.jhnc.org/findimagedupes/findimagedupes-2.18.tar.gz"
  homepage "http://www.jhnc.org/findimagedupes/"
  sha1 'df73609a5c9413925a77357b3c5ff0e9e4a762d3'
  version '2.18'

  # Use brew's perl so that we can install perl dependencies from within this
  # formula
  #depends_on 'perl514'
  # depends_on 'perl-build'

  # FIXME; how do I specify a local path to this formula dep?
  # depends_on 'graphicsmagick' => 'with-perl'

	def install
    bin.install ['findimagedupes']
 		doc.install ['README', 'COPYING', 'history']
  end

  def patches
    #DATA
  end

  def caveats;
    <<-EOS.undent
      You must have my graphicsmagick formula compiled with '--with-perl'.

      This formula does not install the necessary perl dependencies for you. You
      must do so before running this script!

      Required Dependencies:
        $sudo perl -MCPAN -e 'install Inline'
          (Respond 'No' if requested to install 'Inline::C' package)
        $sudo perl -MCPAN -e 'install File::MimeInfo'
        $sudo perl -MCPAN -e 'Install File::MimeInfo::Magic'
        $sudo perl -MCPAN -e 'install Image::Magick'

      If Image::Magick installation from CPAN fails, you may try downloading and
      installing PerlMagick manually from http://search.cpan.org/~jcristy/PerlMagick-6.86/

      You may need to modify Makefile.PL and remove the '-lperl' argument from $LIBS_magick:

        my $LIBS_magick = '-L/usr/local/lib -lMagickCore-6.Q16 -lm';

      I don't know why the patch is failing to apply, so for the time being,
      you must copy new/findimagedupes.pl to /usr/local/bin manually.
    EOS
  end
end

__END__
diff --git a/findimagedupes b/findimagedupes
index 489a7a0..359421d 100755
--- a/findimagedupes
+++ b/findimagedupes
@@ -30,14 +30,14 @@ use Digest::MD5 qw(md5_hex);
 use Getopt::Long qw(:config no_ignore_case require_order);
 use File::MimeInfo::Magic;
 use File::Temp qw(tempdir tempfile);
-use Graphics::Magick;
+use Image::Magick;
 use MIME::Base64;
 use Pod::Usage;

 use Inline
  C => 'DATA',
  NAME => 'findimagedupes',
- DIRECTORY => '/usr/local/lib/findimagedupes';
+ DIRECTORY => '/private/tmp/findimagedupes';

 # ----------------------------------------------------------------------
 #
@@ -138,7 +138,7 @@ my $read_input = grep(/^-$/, @ARGV);
 # XXX: can we tie these to save memory without breaking hv_iterinit() ?
 my (%fpcache, %filelist);

-my $image = Graphics::Magick->new;
+my $image = Image::Magick->new;

 for (@debug) { $debug{$_} = 1 }

--
1.7.11.1

# https://github.com/hjdivad/homebrew/blob/master/Library/Formula/cups-pdf.rb
class CupsPdf < Formula
  desc "PDF printer"
  homepage "https://www.cups-pdf.de/"
  url "https://www.cups-pdf.de/src/cups-pdf_3.0.1.tar.gz"
  sha256 "738669edff7f1469fe5e411202d87f93ba25b45f332a623fb607d49c59aa9531"
  license "GPL-2.0-or-later"

  depends_on "cups"

  # Patch derived from MacPorts.
  # def patches; DATA; end
  patch :DATA

  def install
    system "#{ENV.cc}", "#{ENV.cflags}" "-lcups", "-o", "cups-pdf", "src/cups-pdf.c"

    (etc+"cups").install "extra/cups-pdf.conf"
    (lib+"cups/backend").install "cups-pdf"
    (share+"cups/model").install "extra/CUPS-PDF_opt.ppd"
    (share+"cups/model").install "extra/CUPS-PDF_noopt.ppd"
    
    # TODO(jeff): Perform as much of caveats configuration with Ruby's FileUtils impl [1] as possible [2].
    # 1. https://ruby-doc.org/stdlib-3.1.2/libdoc/fileutils/rdoc/FileUtils.html#method-c-chmod
    # 2. https://docs.brew.sh/Formula-Cookbook#file-level-operations
    # (lib+"cups/backend").chmod 0700, "cups-pdf"
    # (etc+"cups").install_symlink 
  end

  def caveats
    <<-EOF
    In order to use cups-pdf with the Mac OS X printing system change the file
    permissions, symlink the necessary files to their System location and
    have cupsd re-read its configuration using:

    /bin/chmod 0700 #{lib}/cups/backend/cups-pdf
    sudo chown root #{lib}/cups/backend/cups-pdf
    sudo /bin/ln -sf #{etc}/cups/cups-pdf.conf /etc/cups/cups-pdf.conf
    sudo /bin/ln -sf #{lib}/cups/backend/cups-pdf /usr/libexec/cups/backend/cups-pdf
    sudo /bin/chmod -h 0700 /usr/libexec/cups/backend/cups-pdf
    sudo mount -uw /
    sudo /bin/ln -sf #{share}/cups/model/CUPS-PDF_opt.ppd /usr/share/cups/model/CUPS-PDF.ppd

    sudo /bin/mkdir -p /var/spool/cups-pdf/${USER}
    sudo chown ${USER}:staff /var/spool/cups-pdf/${USER}
    /bin/ln -s /var/spool/cups-pdf/${USER} ${HOME}/Documents/cups-pdf
    sudo killall -HUP cupsd
    sudo diskutil mount readOnly -mountPoint / /dev/disk#s#

    NOTE: When uninstalling cups-pdf these symlinks need to be removed manually.
    EOF
  end
end

__END__
diff --git a/extra/cups-pdf.conf b/extra/cups-pdf.conf
index cfb4b78..cc8410d 100644
--- a/extra/cups-pdf.conf
+++ b/extra/cups-pdf.conf
@@ -40,7 +40,7 @@
 ##  root_squash! 
 ### Default: /var/spool/cups-pdf/${USER}
 
-#Out /var/spool/cups-pdf/${USER}
+Out ${HOME}/Documents/cups-pdf/
 
 ### Key: AnonDirName
 ##  ABSOLUTE path for anonymously created PDF files
@@ -82,7 +82,7 @@
 ##                      mixed environments    :  3
 ### Default: 3
 
-#Cut 3
+Cut -1
 
 ### Key: Label
 ##  label all jobs with a unique job-id in order to avoid overwriting old
@@ -91,7 +91,7 @@
 ##  0: label untitled documents only, 1: label all documents
 ### Default: 0
 
-#Label 0
+Label 1
 
 ### Key: TitlePref
 ##  where to look first for a title when creating the output filename
@@ -180,7 +180,7 @@
 ##  created directories and log files
 ### Default: lp
 
-#Grp lp
+Grp _lp
 
 
 ###########################################################################
@@ -239,27 +239,28 @@ Grp _lp
 ### Default: /usr/bin/gs
 
 #GhostScript /usr/bin/gs
+GhostScript /usr/bin/pstopdf
 
 ### Key: GSTmp (config)
 ##  location of temporary files during GhostScript operation 
 ##  this must be user-writable like /var/tmp or /tmp ! 
 ### Default: /var/tmp
 
-#GSTmp /var/tmp
+GSTmp /tmp
 
 ### Key: GSCall (config)
 ## command line for calling GhostScript (!!! DO NOT USE NEWLINES !!!)
 ## MacOSX: for using pstopdf set this to %s %s -o %s %s
 ### Default: %s -q -dCompatibilityLevel=%s -dNOPAUSE -dBATCH -dSAFER -sDEVICE=pdfwrite -sOutputFile="%s" -dAutoRotatePages=/PageByPage -dAutoFilterColorImages=false -dColorImageFilter=/FlateEncode -dPDFSETTINGS=/prepress -c .setpdfwrite -f %s
 
-#GSCall %s -q -dCompatibilityLevel=%s -dNOPAUSE -dBATCH -dSAFER -sDEVICE=pdfwrite -sOutputFile="%s" -dAutoRotatePages=/PageByPage -dAutoFilterColorImages=false -dColorImageFilter=/FlateEncode -dPDFSETTINGS=/prepress -c .setpdfwrite -f %s
+GSCall %s %s -o %s %s
 
 ### Key: PDFVer (config, ppd, lptopions)
 ##  PDF version to be created - can be "1.5", "1.4", "1.3" or "1.2" 
 ##  MacOSX: for using pstopdf set this to an empty value
 ### Default: 1.4
 
-#PDFVer 1.4
+PDFVer
 
 ### Key: PostProcessing (config, lptoptions)
 ##  postprocessing script that will be called after the creation of the PDF

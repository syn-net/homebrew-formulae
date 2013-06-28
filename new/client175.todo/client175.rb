# 2012-04/12:jeff
#
# => client175.rb
#
# Yet another MPD client -- package will host a Python-based web server to share
# its web client front-end (Client175). Unlike 99.98% of others alike, this one
# doesn't suck so bad ^_^
#
# =>    REFERENCES
#
# => 1. http://code.google.com/p/client175/wiki/GettingStarted
#

require 'formula'

class Client175 < Formula
	url 'http://client175.googlecode.com/svn/trunk/ client175', :using => :svn
  	homepage 'http://code.google.com/p/client175/'
  	md5 ''

	def install

		# TODO/FIXME
		# ...
		# Establish a static file hierarchy for mpd web client, perhaps such as
		# /usr/local/Cellar/client175/public/ | /usr/local/var/www/client175/ or
		# so forth!
		# ...
		#

 		#libexec.install ['.libs/mod_fastcgi.so']
 		#doc.install Dir['docs/*']
 		#doc.install ['CHANGES', 'INSTALL', 'INSTALL.AP2', 'README']
 	end

  	def patches
  		DATA
  	end
end

__END__
Index: site.conf
===================================================================
diff --git a/trunk/site.conf b/trunk/site.conf
--- a/trunk/site.conf	(revision 138)
+++ b/trunk/site.conf	(working copy)
@@ -13,7 +13,7 @@

 # Location of the music directory, required for editing tags.  This variable
 # is also used to identify the folder for a given file in local cover lookups.
-music_directory: "~/Music/"
+music_directory: "~/music/"

 # Only change socket_host if you have multiple network interfaces and want
 # to limit which one it listens on.  "0.0.0.0" listens on all interfaces.
@@ -21,17 +21,17 @@

 # Don't run this as root in order to use port 80!  This app was not built
 # to be secure, it must be run with limited access.  Default is port 8080.
-;server.socket_port: 80
+server.socket_port: 8088

 # Setting the 'run_as' variable will allow you to start the process as root
 # and drop the privelages to a restricted user account during server startup.
 # This feature is useful when starting client175 during the init process
 # and/or when starting as root to run on port 80.
-;run_as: "user"
+run_as: "jeff"

 # Setting environment to production removes the verbose console output
 # and disables auto-reload on file changes.
-;environment: "production"
+environment: "production"

 # Setting include_playlist_counts to True will cause the server to count the
 # number of songs and total playtime when listing saved playlists.  If you have

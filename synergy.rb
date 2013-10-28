# Jeffrey Carpenter <jeffrey.carp@gmail.com>
require 'formula'

class Synergy < Formula
  homepage 'http://synergy-foss.org'
  url 'http://synergy.googlecode.com/files/synergy-1.4.15-Source.tar.gz'
  sha1 '0766bc3d95d6971746764d30e0853db14926ae73'
  version '1.4.15'

  # Use the standard environment that leaves the PATH as the user has set it
  # right now -- cmake cannot be found without this line, and I'm too lazy to
  # debug it at the moment! ;P
  env :std

  # Stub for source patching
  def patches; DATA; end

  def install
    opts = [] # Empty stub

    # Ensure, first, that you have the appropriate installed paths for the OSX
    # SDK as per http://synergy-foss.org/wiki/Compiling#Mac_OS_X_10.4_and_above
    # or this is likely to fail..!
    system "./hm.sh conf -g1 --mac-sdk=10.8"

    system "./hm.sh build"

    bin.install Dir['bin/*']

    # TODO (man pages, etc docs)
    #etc.install ['doc/synergy.conf.example', 'doc/synergy.conf.example-advanced', 'doc/synergy.conf.example-basic']
    #etc.install ['doc/org.synergy-foss.org.synergyc.plist', 'doc/org.synergy-foss.org.synergys.plist']

    #man1.install ['doc/synergyc.man', 'doc/synergys.man']
      #mv synergyc.man /usr/local/share/man/man8/synergyc.8
      #mv synergys.man /usr/local/share/man/man8/synergys.8
  end

  # TODO: Display caveat about /private/var/log/synergy.log -- or re-route
  # path to a more sensible location.
  def caveats;
    <<-EOS.undent
      Load launchd agents:
        launchctl load -w ~/Library/LaunchAgents/org.local.synergys.plist
    EOS
  end
end
__END__

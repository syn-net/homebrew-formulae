# 2012-04/03:jeff
#
# =>  pow.rb
#
# Homebrew formula for latest git repo version of Pow
#
# =>    PATCHES
#
# => 1. https://github.com/37signals/pow/pull/270/files
#

require 'formula'

class Pow < Formula
  url '~/src/pow.git', :using => :git
  homepage 'http://pow.cx/'
  version '2012.04.03'

  depends_on 'node'

  def install
    (prefix+'pow').install Dir['*']

    bin.mkdir
    File.open("#{bin}/pow", 'w') do |f|
      f.write <<-EOS.undent
        #!/bin/sh
        export POW_BIN="#{HOMEBREW_PREFIX}/bin/pow"
        exec "#{HOMEBREW_PREFIX}/bin/node" "#{prefix}/pow/lib/command.js" "$@"
      EOS
    end
    system "chmod +x #{bin}/pow"
  end

  def caveats;
    <<-EOS.undent
      Sets up firewall rules to forward port 80 to Pow:
        sudo pow --install-system

      Installs launchd agent to start on login:
        pow --install-local

    EOS
  end
end

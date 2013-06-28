require 'formula'

class SshAskpass < Formula
  homepage 'https://github.com/markcarver/mac-ssh-askpass'
  url 'git://synlocal.redirectme.net/projects/homebrew/
  md5 ''
  version '0.1'

  def install
	 system "sh INSTALL"
  end

  def test
    system "/usr/local/libexec/ssh-askpass"
  end
end

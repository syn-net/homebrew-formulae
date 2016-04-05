require 'formula'

class Htop < Formula

  homepage "https://github.com/hishamhm/htop.git"
  desc "htop is an interactive text-mode process viewer for Unix systems. It aims to be a better 'top'"
  # url "https://github.com/hishamhm/htop.git"
  # version "1.0.3"
  # sha256 "f03874dec3fc28a9d0036820c05f908bbc45baa208c459664d8584f8acd7b7f6"

  # The master branch incorporates the necessary build fix for building the
  # official Darwin port of htop.
  # https://github.com/hishamhm/htop/pull/269 --
  head "https://github.com/hishamhm/htop.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  option 'with-debug', 'Enable debug build and disable optimization'

  def install
    args = []

    system "./autogen.sh"

    args << "--disable-dependency-tracking"
    args << "--enable-taskstats"
    args << "--disable-unicode"
    args << "--prefix=#{prefix}"
    system "./configure", *args

    if build.include? 'with-debug'
      ENV.deparallelize                           # helps reading stdout
      (ENV.compiler == :clang) ? ENV.Og : ENV.O2  # optimize debug properly
    end

    system "DEFAULT_INCLUDES='-iquote .' make"
    system "make install"

    # This bit is borrowed from the original htop-osx.rb formula (providing us
    # with the unofficial htop-osx port by cynthia).
    rm_rf "#{share}/applications" # Don't need Gnome support on OS X
    rm_rf "#{share}/pixmaps"
  end

  def caveats; <<-EOS.undent
    htop-osx requires root privileges to correctly display all running processes.
    so you will need to do one of the following:
        a) run `sudo htop` every time
        b) change the owner and permissions:
            cd #{bin}
            chmod 6555 htop
            sudo chown root htop
    You should be certain that you trust any software you grant root privileges.
    EOS
  end

  test do
    ENV["TERM"] = "xterm"
    pipe_output("#{bin}/htop", "q")
    assert $?.success?
  end
end

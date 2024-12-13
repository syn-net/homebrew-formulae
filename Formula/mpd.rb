#ENV.CC = "/usr/local/Cellar/gcc/14.2.0_1/bin/gcc-14"
#ENV['CXX'] = "/usr/local/Cellar/gcc/14.2.0_1/bin/g++-14"
# FIXME(JEFF): Building the documentation requires additional deps;
# sphinx-build
#-Dsmbclient=disabled # NOTE(JEFF): smbclient feature is broken due to a "serious bug" that crashes MPD
#-Dopenal=enabled # IMPORTANT(JEFF): This is a useful alternative audio backend on MacOS
#
# 1. https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/m/mpd.rb
# 2. https://gitlab.archlinux.org/archlinux/packaging/packages/mpd/-/blob/main/PKGBUILD
class Mpd < Formula
  desc "Music Player Daemon"
  homepage "https://web.archive.org/web/20230506090801/https://www.musicpd.org/"
  url "https://github.com/MusicPlayerDaemon/MPD/archive/refs/tags/v0.23.13.tar.gz"
  sha256 "c002fd15033d791c8ac3dcc009b728b0e8440ed483ba56e3ff8964587fe9f97d"
  license "GPL-2.0-or-later"
  head "https://github.com/MusicPlayerDaemon/MPD.git", branch: "master"

  depends_on "boost" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "bzip2"
  depends_on "chromaprint"
  depends_on "expat"
  depends_on "faad2"
  depends_on "flac"
  depends_on "ffmpeg"
  depends_on "fluid-synth"
  depends_on "fluidsynth"
  depends_on "fmt"
  depends_on "glib"
  depends_on "lame"
  depends_on "libao"
  depends_on "libcdio"
  depends_on "libgcrypt"
  depends_on "libgme"
  depends_on "libid3tag"
  depends_on "libmad"
  depends_on "libmpd"
  depends_on "libmpdclient"
  depends_on "libnfs"
  depends_on "libsamplerate"
  depends_on "libshout"
  depends_on "libupnp"
  depends_on "libvorbis"
  depends_on "opus"
  depends_on "sqlite"
  depends_on "twolame"
  depends_on "yajl"
  depends_on "libogg"

  uses_from_macos "curl"
  depends_on macos: :mojave # requires C++17 features unavailable in High Sierra
  uses_from_macos "curl"
  uses_from_macos "bzip2"
  uses_from_macos "zlib"

  on_linux do
    depends_on "icu4c"
    depends_on "ffmpeg"
    depends_on "systemd" => :build
    depends_on "alsa-lib"
    depends_on "dbus"
    depends_on "jack"
    depends_on "pulseaudio"
    depends_on "pipewire"
    depends_on "systemd"
  end

  fails_with gcc: "5"

  # Compatibility with fmt 11
  patch do
    url "https://github.com/MusicPlayerDaemon/MPD/commit/3648475f871c33daa9e598c102a16e5a1a4d4dfc.patch?full_index=1"
    sha256 "5733f66678b3842c8721c75501f6c25085808efc42881847af11696cc545848e"
  end

  # Fix missing include
  patch do
    url "https://github.com/MusicPlayerDaemon/MPD/commit/e380ae90ebb6325d1820b6f34e10bf3474710899.patch?full_index=1"
    sha256 "661492a420adc11a3d8ca0c4bf15e771f56e2dcf1fd0042eb6ee4fb3a736bd12"
  end

  # Backport support for ICU 76+
  # Ref: https://github.com/MusicPlayerDaemon/MPD/pull/2140
  patch :DATA
  
  def install
    # mpd specifies -std=gnu++0x, but clang appears to try to build
    # that against libstdc++ anyway, which won't work.
    # The build is fine with G++.
    ENV.libcxx
    #ENV['PKG_CONFIG_PATH'] += "/usr/local/opt/icu4c@76/lib/pkgconfig"
    ENV['CXX'] = "g++-14"

    #-Dsoundcloud=enabled
    args = %W[
      --sysconfdir=#{etc}
      -Ddocumentation=disabled
      -Dmanpages=true
      -Dneighbor=true
      -Dwebdav=disabled
      -Dlibmpdclient=enabled
      -Ddatabase=true
      -Dsmbclient=disabled
      -Dopenal=enabled
      -Db_ndebug=true
      -Dffmpeg=disabled
      -Dicu=disabled
      -Dsystemd_user_unit_dir=#{lib}/systemd/user
      -Dsystemd_system_unit_dir=#{lib}/systemd/system
    ]

    system "meson", "setup", "output/release", *args, *std_meson_args
    system "meson", "compile", "-C", "output/release", "--verbose"
    ENV.deparallelize # Directories are created in parallel, so let's not do that
    system "meson", "install", "-C", "output/release"

    pkgetc.install "doc/mpdconf.example" => "mpd.conf"

    # FIXME(jeff): We need to create these two files in order for proper operation
    # of the mpd systemd service script. I need to research this further in order 
    # to understand where these files originate from.
    if OS.linux?
      #system "install", "-vDm", "644", "mpd.sysusers", "#{lib}/sysusers.d/mpd.conf"
      #system "install", "-vDm", "644", "mpd.tmpfiles", "#{lib}/tmpfiles.d/mpd.conf"
    end
  end

  def caveats
    <<~EOS
      MPD requires a config file to start.
      Please copy it from #{etc}/mpd/mpd.conf into one of these paths:
        - ~/.mpd/mpd.conf
        - ~/.mpdconf
      and tailor it to your needs.
    EOS
  end

  service do
    run [opt_bin/"mpd", "--no-daemon"]
    keep_alive true
    process_type :interactive
    working_dir HOMEBREW_PREFIX
  end

  test do
    # oss_output: Error opening OSS device "/dev/dsp": No such file or directory
    # oss_output: Error opening OSS device "/dev/sound/dsp": No such file or directory
    return if OS.linux? && ENV["HOMEBREW_GITHUB_ACTIONS"]

    require "expect"

    port = free_port

    (testpath/"mpd.conf").write <<~EOS
      bind_to_address "127.0.0.1"
      port "#{port}"
    EOS

    io = IO.popen("#{bin}/mpd --stdout --no-daemon #{testpath}/mpd.conf 2>&1", "r")
    io.expect("output: Successfully detected a osx audio device", 30)

    ohai "Connect to MPD command (localhost:#{port})"
    TCPSocket.open("localhost", port) do |sock|
      assert_match "OK MPD", sock.gets
      ohai "Ping server"
      sock.puts("ping")
      assert_match "OK", sock.gets
      sock.close
    end
  end
end

__END__
diff --git a/src/lib/icu/meson.build b/src/lib/icu/meson.build
index 92f9e6b1f..3d52213a9 100644
--- a/src/lib/icu/meson.build
+++ b/src/lib/icu/meson.build
@@ -1,5 +1,7 @@
-icu_dep = dependency('icu-i18n', version: '>= 50', required: get_option('icu'))
-conf.set('HAVE_ICU', icu_dep.found())
+icu_i18n_dep = dependency('icu-i18n', version: '>= 50', required: get_option('icu'))
+icu_uc_dep = dependency('icu-uc', version: '>= 50', required: get_option('icu'))
+have_icu = icu_i18n_dep.found() and icu_uc_dep.found()
+conf.set('HAVE_ICU', have_icu)
 
 icu_sources = [
   'CaseFold.cxx',
@@ -13,7 +15,7 @@ if is_windows
 endif
 
 iconv_dep = []
-if icu_dep.found()
+if have_icu
   icu_sources += [
     'Util.cxx',
     'Init.cxx',
@@ -44,7 +46,8 @@ icu = static_library(
   icu_sources,
   include_directories: inc,
   dependencies: [
-    icu_dep,
+    icu_i18n_dep,
+    icu_uc_dep,
     iconv_dep,
     fmt_dep,
   ],
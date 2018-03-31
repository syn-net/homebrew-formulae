cask 'mpv' do
  version '0.26.0'
  sha256 '0f3c7a2f8c0e37f8542a12170149ff9b9a462abd10e35fe6e88e689fe1815443'

  # laboratory.stolendata.net/~djinn/mpv_osx was verified as official when first introduced to the cask
  url "https://laboratory.stolendata.net/~djinn/mpv_osx/mpv-#{version}.tar.gz"
  appcast 'https://laboratory.stolendata.net/~djinn/mpv_osx/',
          checkpoint: 'fe0ed3e95961933cd830d73bb3c45f0b2e13029b941c7135ddc9068ca89816c7'
  name 'mpv'
  homepage 'https://mpv.io/'

  app 'mpv.app'
  binary "#{appdir}/mpv.app/Contents/MacOS/mpv"

  zap trash: [
               '~/.config/mpv',
               '~/Library/Logs/mpv.log',
               '~/Library/Preferences/io.mpv.plist',
               '~/Library/Preferences/mpv.plist',
             ]
end

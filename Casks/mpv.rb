cask 'mpv' do
  # https://laboratory.stolendata.net/~djinn/mpv_osx/
  version '0.24.0'
  sha256 '9c5f6a698f916ac8c11dbe38a1a753d3e6036a13e57773763cb27e41b3733b99'

  # laboratory.stolendata.net/~djinn/mpv_osx was verified as official when first introduced to the cask
  url "https://laboratory.stolendata.net/~djinn/mpv_osx/mpv-#{version}.tar.gz"
  #appcast 'https://laboratory.stolendata.net/~djinn/mpv_osx/',
          #checkpoint: 'fe0ed3e95961933cd830d73bb3c45f0b2e13029b941c7135ddc9068ca89816c7'
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

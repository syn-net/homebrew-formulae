cask 'xca' do
  # This is a workaround patch for the v1.4.1 DMG, which seems to be one of:
  # a) invalid; b) newer DMG variant that is unable to be opened by a MacOS
  # v10.11.6 era system!
  if MacOS.version < 10.13 # MacOS High Sierra
    version '1.4.0'
    sha256 '21d3f6e8199918173a188987de093dc9f16a867ccefb8c348950bb7d843cb1d8'

    # github.com/chris2511/xca was verified as official when first introduced to the cask
    url "https://github.com/chris2511/xca/releases/download/RELEASE.#{version}/xca-#{version}.dmg"
  else
    version '1.4.1'
    sha256 '6d76ac92774d6bc336b1ac21a5bfeb6c83d2426421a39a9fd7b22ef16cd894cb'

    # github.com/chris2511/xca was verified as official when first introduced to the cask
    url "https://github.com/chris2511/xca/releases/download/RELEASE.#{version}/xca-#{version}.dmg"
  end

  appcast 'https://github.com/chris2511/xca/releases.atom',
          checkpoint: '802f6d038e3e40197cfc9ea4f6b19bb786b1bddf1180821013c64a9e1a9af956'

  name 'XCA'
  homepage 'http://hohnstaedt.de/xca/'

  app 'xca.app'
end

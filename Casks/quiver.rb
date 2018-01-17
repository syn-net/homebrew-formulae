cask 'quiver' do
  version '3.0.1'
  sha256 '7119030ed6e0e89b899d20b0294c80bbc741b0af15f67a5f933f7cdf7b96281c'

  url 'http://happenapps.com/downloads/QuiverFreeTrial.zip'
  name 'Quiver'
  homepage 'http://happenapps.com/#quiver'
  # issues 'https://github.com/HappenApps/Quiver/issues'
  # wiki 'https://github.com/HappenApps/Quiver/wiki'
  license :commercial

  auto_updates true

  app 'Quiver.app'

  zap delete: [
                '/Users/jeff/Library/Containers/com.happenapps.Quiver'
              ]
end

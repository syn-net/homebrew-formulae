cask 'cantata' do
  # Cantata version 2.2.0+ is compiled against the MacOS 10.12.x SDK, 
  # making version 2.0.1 the last one that runs on MacOS 10.11.x
  version '2.0.1'
  sha256 '534fc39e4b540a2aafbcb06f175af2a772fd503a9f7434a9be2bb82a39a78277'

  url "https://github.com/CDrummond/cantata/releases/download/v#{version}/Cantata-#{version}.dmg"
  appcast 'https://github.com/CDrummond/cantata/releases.atom',
          checkpoint: '2ec33166423bf32795c06f1224f21efbf29f0bcce35e6ceb9d6af2277d376106'
  name 'Cantata'
  homepage 'https://github.com/cdrummond/cantata'

  app 'Cantata.app'
end

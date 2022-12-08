cask 'fritzing' do
  version '10.2'
  sha256 'e991b66628730ee52334ea307a42a32fd27cbd66904ef5e4e76815cf37594cef'
  url "https://github.com/fritzing/fritzing-app/releases/download/CD-548/fritzing-3d61c58421bdb63ca903bb5d11310a257f1ec0ed-develop-548.mojave.#{version}.dmg",
    verified: "https://github.com/fritzing/fritzing-app/"
  name 'fritzing'
  homepage 'https://fritzing.org/'
  desc 'Fritzing is an open-source hardware initiative that makes electronics accessible as a creative material for anyone.'
  app 'Fritzing.app'
end

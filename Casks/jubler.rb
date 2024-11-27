cask 'jubler' do
  version '6.0.pre6'
  sha256 '4c129bae8bfa6af2fb01a2414f7e0f6cefe1c87ea1c129c7b00949a5a2c750a2'

  # PLEASE NOTE: for macOS 10.13, there is a problem with all Java
  # applications: please use the following link to download a beta version
  # to solve this issue.
  # sourceforge.net/jubler was verified as official when first introduced to the cask
  url "https://github.com/teras/Jubler/releases/download/#{version}/Jubler-#{version}.dmg"

  name 'Jubler'
  homepage 'http://www.jubler.org/'

  app 'Jubler.app'

  caveats do
    depends_on_java
  end
end

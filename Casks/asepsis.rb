cask 'asepsis' do
  name 'Asepsis'
  url 'http://downloads.binaryage.com/Asepsis-1.5.2.dmg'
  homepage 'http://asepsis.binaryage.com/'
  version '1.5.2'
  sha256 'b7c101fd216364423d7de9009aa9e82934042f0403479746fbe604a8b5f3883b'
  # install 'Asepsis.mpkg'
  uninstall :pkgutil => 'com.binaryage.pkg.asepsis'

end

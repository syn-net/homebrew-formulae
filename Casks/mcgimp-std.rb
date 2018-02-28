cask 'mcgimp-std' do
  version '2.9.89'
  sha256 '95a7e2d1e53423e92c88aac2cdcd5f2a886eded94353aecc1edfd1b01fdc3eb4'

  url 'http://www.partha.com/downloads/McGimp-2.9-std.app.zip'
  name 'GIMP'
  homepage 'http://www.partha.com'

  app 'McGimp-2.9-std.app'

  postflight do
    set_permissions "#{appdir}/McGimp-2.9-std.app/Contents/MacOS/mcgimp-std",
      'a+rx'
  end

  zap trash: [
    '~/Library/Preferences/gimp-2.9.plist',
    # '~/Library/Application Support/GIMP',
  ]

end

cask 'mcgimp-std' do
  version '2.9.6'
  sha256 '51442d6f0e48341bf2002eef75f366994b47bd31c6afb9f9855683623582cb93'

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

cask 'mcgimp-std' do
  version '2.10'
  sha256 '3a73df217efaa2a53913e1f0884e8e3d4377b53faf0a9c885ad4250903297afb'

  url 'https://www.partha.com/downloads/McGimp-2.10-std.app.zip'  
  name 'GIMP'
  homepage 'http://www.partha.com'

  app 'McGimp-2.10-std.app'

  postflight do
    set_permissions "#{appdir}/McGimp-2.10-std.app/Contents/MacOS/mcgimp-std",
      'a+rx'
  end

  zap trash: [
    '~/Library/Preferences/gimp-2.10.plist',
    # '~/Library/Application Support/GIMP',
  ]

end

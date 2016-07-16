cask 'mcgimp' do
  version '2.9.3'
  # sha256 '898e98082410db2ab1bcca5c8ffcea2dd3f75798e304d80146976f92e0b684df'
  sha256 'fd98c0a31c719914ac05868a6366bab884c40c4504d04a55df6d263dbc5bfc02'

  url 'http://www.partha.com/downloads/McGimp-2.9.app.zip'
  name 'McGIMP'
  homepage 'http://www.partha.com'
  license :gpl
  app 'McGimp-2.9.app'
end

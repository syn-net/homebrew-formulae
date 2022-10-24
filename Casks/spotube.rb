cask "spotube" do
  version "2.5.0"
  sha256 "e30642d39dc0b41a8ef267ee627dfc91eaf06e9f10b68fc242385f0234660f7a"

  url "https://github.com/KRTirtho/spotube/releases/download/v#{version}/Spotube-macos-x86_64.dmg",
      verified: "github.com/KRTirtho/spotube/"
  name "spotube"
  desc "A fast, modern, lightweight & efficient Spotify Music Client for every platform"
  homepage "https://spotube.netlify.app"

  depends_on macos: ">= :catalina"

  app "spotube.app"
  binary "#{appdir}/spotube.app/Contents/MacOS/spotube"
end

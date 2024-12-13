#!/bin/sh
#
#
#

if [ "$1" = "install" ]; then
  brew install --cask steam

  diskutil apfs addVolume disk1 APFS Steam

  mv /Applications/Steam.app /Volumes/Steam/Steam.app
  ln -s /Volumes/Steam/Steam.app /Applications/Steam.app
  if [ -e ~/Library/Application\ Support/Steam ]; then
    mv ~/Library/Application\ Support/Steam /Volumes/Steam/Library
    ln -s /Volumes/Steam/Library ~/Library/Application\ Support/Steam
  fi
else
  mv /Applications/Steam.app /Volumes/Steam/Steam.app
  ln -s /Volumes/Steam/Steam.app /Applications/Steam.app
  if [ -e ~/Library/Application\ Support/Steam ]; then
    mv ~/Library/Application\ Support/Steam /Volumes/Steam/Library
    ln -s /Volumes/Steam/Library ~/Library/Application\ Support/Steam
  fi
fi


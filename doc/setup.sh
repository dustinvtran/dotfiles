#!/bin/sh
# Resources:
#+ system with app store, easysimbl, homebrew, and caskroom
#http://www.lowindata.com/2013/installing-scientific-python-on-mac-os-x/#numpy
#+ python with pip and virtualenv
#  http://docs.python-guide.org/en/latest/starting/install/osx/
#+ tex live
#  TODO
#+ defaults: npm, rwm
echo "Install all AppStore Apps at first:
  xcode
  omnifocus
  twitterific
Install manually:
  osxfuse
"
read -p "Press any key to continue... " -n1 -s
echo " '\n'"

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap homebrew/science
# This list is out of date and hard to maintain. Just see the list in
# the archives.
brew install wget
brew install ffmpeg

brew install caskroom/cask/brew-cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Primary
brew cask install dropbox
brew cask install firefox
brew cask install iterm2

# Systems
brew cask install asepsis
brew cask install flash
brew cask install karabiner
brew cask install slate
brew cask install easysimbl
brew cask install java
brew cask install seil
brew cask install xquartz

# Media
brew cask install spotify
brew cask install spotify-notifications

# Utilities
brew cask install hipchat
brew cask install libreoffice
brew cask install utorrent

# Nice to have
brew cask install atom
brew cask install eclipse-ide
brew cask install google-chrome
brew cask install sublime-text
brew cask install vlc

# Development
brew install macvim
brew install postgresql
brew install vim
brew cask install mactex

# Social
brew cask install google-hangouts

# cleanup
brew cleanup
brew cask cleanup

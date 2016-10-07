#!/bin/sh
#+ system with app store
#+ homebrew, and caskroom
#+ python, pip, virtualenv
#  http://www.lowindata.com/2013/installing-scientific-python-on-mac-os-x/#numpy
#  http://docs.python-guide.org/en/latest/starting/install/osx/
#+ latex
#  install mactex, then mtpro2 (local file) manually
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
# see brew list
brew install ...
brew install ffmpeg

brew install caskroom/cask/brew-cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# see cask list
brew cask install ...

# cleanup
brew cleanup
brew cask cleanup

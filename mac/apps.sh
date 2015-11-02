#!/bin/bash
#####################################
# Install mac apps
#####################################

######### HELP

[[ "$1" == "source" ]] || \

echo 'Apps - JHH3 (jhh3.com)'

if [[ "$1" == "-h" || "$1" == "--help" ]]; then cat <<HELP
Usage: $(basename "$0")
See the README for documentation.
https://github.com/jholliman/dotfiles
HELP
exit;
fi

######### HOMEBREW

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

######### BINARIES

binaries=(
 git
 node
 python
 tree
 trash
)

echo "Installing binaries..."
brew install ${binaries[@]}
brew cleanup

######### SOFTWARE

apps=(
 appcleaner
 caffeine
 cheatsheet
 flux
 google-chrome
 iterm2
 menubar-countdown
 one-password
 shiftit
 spotify
 sublime-text
 transmission
 vagrant
 virtualbox
 vlc
)

echo "Installing apps..."
brew cask install --appdir=/Applications ${apps}

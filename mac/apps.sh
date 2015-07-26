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

######### SOFTWARE

brew cask install caffeine
brew cask install cheatsheet
brew cask install google-chrome
brew cask install flux
brew cask install sublime-text
brew cask install transmission
brew cask install vlc


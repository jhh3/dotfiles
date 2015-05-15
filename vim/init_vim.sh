#!/bin/bash

# Make sure git is installed.
OS_T="$OSTYPE"
if [[ $OS_T == "linux-gnu" ]]; then
  # Linux (Ubuntu)
  sudo apt-get install vim
  sudo apt-get install git
  sudo apt-get install python-pip
elif [[ $OS_T == "darwin"* ]]; then
  # MAC OS
  brew install git
fi

# Make the necessary directories.
[ -e ~/.vim ] || mkdir -p ~/.vim
[ -e ~/.vim/bundle ] || mkdir -p ~/.vim/bundle
[ -e ~/.vim/after/ftplugin ] || mkdir -p ~/.vim/after/ftplugin
[ -e ~/.vim/colors ] || mkdir -p ~/.vim/colors

# Install vim plugins and their dependencies.
[ -e ~/.vim/bundle/Vundle.vim ] || git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Python dependencies for syntastic.
if ! $(python -c "import pep8" &> /dev/null); then sudo pip install pep8; fi;
if ! $(python -c "import autopep8" &> /dev/null); then sudo pip install autopep8; fi;
if ! $(python -c "import pyflakes" &> /dev/null); then sudo pip install pyflakes; fi;

# Copy over the necessary files.
cp ftplugin/*.vim ~/.vim/after/ftplugin
cp colors/*.vim ~/.vim/colors
cp vimrc ~/.vimrc


#!/bin/bash

echo "Starting John Holliman's vim setup."

# Make sure git is installed.
OS_T="$OSTYPE"
if [[ OS_T == "linux-gnu" ]]; then
  # MAC OS
  sudo apt-get install git
  sudo apt-get install python-pip
elif [[ OS_T == "darwin"* ]]; then
  # Linux (Ubuntu)
  brew install git
fi

# Make the necessary directories.
[ -e ~/.vim ] || mdkir -p ~/.vim
[ -e ~/.vim/bundle ] || mdkir -p ~/.vim/bundle
[ -e ~/.vim/after/ftplugin ] || mdkir -p ~/.vim/after/ftplugin
[ -e ~/.vim/colors ] || mdkir -p ~/.vim/colors

# Install vim plugins and their dependencies.
[ -e ~/.vim/bundle/Vundle.vim ] || git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
[ -e ~/.vim/bundle/syntastic ] || git clone https://github.com/scrooloose/syntastic.git ~/.vim/bundle/syntastic
[ -e ~/.vim/bundle/nerdtree ] || git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
pip install pep8
pip install autopep8
pip install pyflakes
[ -e ~/.vim/bundle/vim-go ] || git clone https://github.com/fatih/vim-go.git ~/.vim/bundle/vim-go

# Copy over the necessary files.
cp ftplugin/*vim ~/.vim/ftplugin
cp vimrc ~/.vimrc

echo "Done setting up vim."
echo "You can delete this repo now."
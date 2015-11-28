#!/bin/bash
#####################################
# dotfiles
#####################################

######### HELP

[[ "$1" == "source" ]] || \

echo 'Dotfiles - JHH3 (jhh3.com)'

if [[ "$1" == "-h" || "$1" == "--help" ]]; then cat <<HELP
Usage: $(basename "$0")
See the README for documentation.
https://github.com/jholliman/dotfiles
HELP
exit; 
fi

######### VARIABLES

dir=`pwd`/links
bindir=`pwd`/bin
cpdir=`pwd`/copy

######### INSTALL LIBS

OS_T="$OSTYPE"
if [[ $OS_T == "linux-gnu" ]]
then
	# Linux
	python -mplatform || grep centos && sudo yum -y update || sudo apt-get -y update
	python -mplatform || grep centos && sudo yum -y install vim || sudo apt-get -y install vim
	python -mplatform || grep centos && sudo yum -y install git || sudo apt-get -y install git
	python -mplatform || grep centos && sudo yum -y install python-pip || sudo apt-get -y install python-pip
	python -mplatform || grep centos && sudo yum -y install zsh || sudo apt-get -y install zsh
elif [[ $OS_T == "darwin"* ]] 
then
	# MAC OS
	brew install git > /dev/null 2>&1
	brew install zsh > /dev/null 2>&1
	brew install caskroom/cask/brew-cask
	brew update && brew upgrade brew-cask && brew cleanup
fi

[ -e ~/.oh-my-zsh ] || sudo sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

######### Make links

## VIM
echo "--> Adding vim symlinks"
ln -sf $dir/vimrc ~/.vimrc
ln -sf $dir/.vim ~

# YCM conf
cp $cpdir/ycm_extra_conf.py ~/.ycm_extra_conf

# Install vim plugins and their dependencies.
echo "	--> Installing vundle"
[ -e ~/.vim/bundle/Vundle.vim ] || git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Python dependencies for syntastic.
echo "	--> Installing python dependencies for syntastic"
if ! $(python -c "import pep8" &> /dev/null); then sudo pip install pep8; fi;
if ! $(python -c "import autopep8" &> /dev/null); then sudo pip install autopep8; fi;
if ! $(python -c "import pyflakes" &> /dev/null); then sudo pip install pyflakes; fi;

## TMUX
echo "--> Adding tmux symlink"
ln -sf $dir/tmux.conf ~/.tmux.conf

## GIT
echo "--> Adding git symlink"
ln -sf $dir/gitconfig ~/.gitconfig
ln -sf $dir/gitignore ~/.gitignore

## ZSHRC
echo "--> Adding zshrc symlink"
cp $cpdir/jhh3.zsh-theme ~/.oh-my-zsh/themes
cp $dir/zshrc $dir/zshrc_auto
ln -sf $dir/zshrc_auto ~/.zshrc

## BIN 
echo "--> Adding bin to path"
echo 'export PATH='$bindir':$PATH' >> ~/.zshrc

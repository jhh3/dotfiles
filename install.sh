#!/bin/bash
#####################################
# dotfiles
#####################################

######### HELP

[[ "$1" == "source" ]] || \

echo 'Dotfiles - JHH3 (jhh3.com)'
echo

if [[ "$1" == "-h" || "$1" == "--help" ]]; then cat <<HELP
Usage: $(basename "$0")
See the README for documentation.
https://github.com/jholliman/dotfiles
HELP
exit;
fi

######### VARIABLES

dir=`pwd`/links
install_dir=`pwd`/install
bindir=`pwd`/bin
cpdir=`pwd`/copy

######### INSTALL LIBS

$install_dir/sh-install.sh
source ~/.zshrc

read -p "Would you like to set up Vim (Y/N)? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	$install_dir/vim-install.sh
fi

read -p "Would you like to set up Tmux (Y/N)? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "--> Adding tmux symlink"
	ln -sf $dir/tmux.conf ~/.tmux.conf
fi

read -p "Would you like to set up Git (Y/N)? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "--> Adding git symlink"
	ln -sf $dir/gitconfig ~/.gitconfig
	ln -sf $dir/gitignore ~/.gitignore
fi

## GIT
echo "--> Adding git symlink"

#OS_T="$OSTYPE"
#if [[ $OS_T == "linux-gnu" ]]
#then
#	# Linux
#	python -mplatform || grep centos && sudo yum -y update || sudo apt-get -y update
#	python -mplatform || grep centos && sudo yum -y install vim || sudo apt-get -y install vim
#	python -mplatform || grep centos && sudo yum -y install git || sudo apt-get -y install git
#	python -mplatform || grep centos && sudo yum -y install python-pip || sudo apt-get -y install python-pip
#	python -mplatform || grep centos && sudo yum -y install zsh || sudo apt-get -y install zsh
#elif [[ $OS_T == "darwin"* ]]
#then
#	# MAC OS
#	brew install git > /dev/null 2>&1
#	brew install zsh > /dev/null 2>&1
#	brew install neovim/neovim/neovim > /dev/null 2>&1
#	brew install caskroom/cask/brew-cask
#	brew update && brew upgrade brew-cask && brew cleanup
#fi
#
#[ -e ~/.oh-my-zsh ] || sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#

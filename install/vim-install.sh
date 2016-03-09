#!/bin/bash
#####################################
# Vim install
#####################################

echo "Setting up Vim..."
read -p "Do you want to use neovim (Y/N)? " -n 1 -r
echo

dir=`pwd`/links
cpdir=`pwd`/copy

OS_T="$OSTYPE"
if [[ $OS_T == "linux-gnu" ]]
then
	# Linux
	python -mplatform || grep centos && sudo yum -y update || sudo apt-get -y update
	python -mplatform || grep centos && sudo yum -y install vim || sudo apt-get -y install vim
	python -mplatform || grep centos && sudo yum -y install git || sudo apt-get -y install git
	python -mplatform || grep centos && sudo yum -y install python-pip || sudo apt-get -y install python-pip
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		sudo apt-get install software-properties-common
		sudo apt-get install python-dev python-pip python3-dev python3-pip
		sudo add-apt-repository ppa:neovim-ppa/unstable
		sudo apt-get update
		sudo apt-get install neovim
	fi
elif [[ $OS_T == "darwin"* ]]
then
	# MAC OS
	brew install git > /dev/null 2>&1
	brew install zsh > /dev/null 2>&1
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		brew install neovim/neovim/neovim > /dev/null 2>&1
	fi
fi

######### Make links

## VIM
echo "--> Adding vim symlinks"
ln -sf $dir/vimrc ~/.vimrc
if [[ $REPLY =~ ^[Yy]$ ]]
then
	ln -sf $dir/vimrc $dir/.vim/init.vim # For neovim
fi
ln -sf $dir/.vim ~

# YCM conf
cp $cpdir/ycm_extra_conf.py ~/.ycm_extra_conf

# Python dependencies for syntastic.
echo "	--> Installing python dependencies"

mkvirtualenv vim && workon vim && pip install pep8 autopep8 pyflakes neovim && deactivate vim

# Install vim plugins and their dependencies.
echo "	--> Installing vundle"
[ -e ~/.vim/bundle/Vundle.vim ] || git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall


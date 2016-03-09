#!/bin/bash
#####################################
# Shell install
#####################################

echo "Setting up Zsh"

dir=`pwd`/links
install_dir=`pwd`/install
bindir=`pwd`/bin
cpdir=`pwd`/copy

OS_T="$OSTYPE"
if [[ $OS_T == "linux-gnu" ]]
then
	# Linux
	python -mplatform || grep centos && sudo yum -y update || sudo apt-get -y update
	python -mplatform || grep centos && sudo yum -y install git || sudo apt-get -y install git
	python -mplatform || grep centos && sudo yum -y install python-pip || sudo apt-get -y install python-pip
	python -mplatform || grep centos && sudo yum -y install zsh || sudo apt-get -y install zsh
elif [[ $OS_T == "darwin"* ]]
then
	# MAC OS
	brew install git > /dev/null 2>&1
	brew install zsh > /dev/null 2>&1
fi

[ -e ~/.oh-my-zsh ] || sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Python virtualenv
sudo pip install virtualenv
pip install --user virtualenvwrapper

## ZSHRC
echo "--> Adding zshrc symlink"
cp $cpdir/jhh3.zsh-theme ~/.oh-my-zsh/themes
cp $dir/zshrc $dir/zshrc_auto
ln -sf $dir/zshrc_auto ~/.zshrc

## BIN
echo "--> Adding bin to path"
echo 'export PATH='$bindir':$PATH' >> ~/.zshrc

echo "--> Setting up virtualenvwrapper"

echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.zshrc
echo "export PROJECT_HOME=$HOME/Projects" >> ~/.zshrc
echo "source $HOME/.local/bin/virtualenvwrapper.sh" >> ~/.zshrc

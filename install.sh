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

# Update MAC software
sudo softwareupdate -i -a
sudo `pwd`/osx/osx-defaults.sh

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

# Install binaries
binaries=(
	git
	node
	tree
	wget
	zsh
 	trash
	ctags
)

echo "Installing binaries..."
brew install ${binaries[@]}
brew cleanup

# Install applications
apps=(
 google-chrome
 iterm2-beta
 shiftit
 skim
 spotify
 transmission
 vagrant
 vagrant-manager
 virtualbox
 vlc
)

echo "Installing apps..."
brew tap caskroom/cask
brew cask install --appdir=/Applications ${apps[@]}

echo "Setting up Zsh"
ln -sf `pwd`/oh-my-zsh ~/.oh-my-zsh
chsh -s $(grep /zsh$ /etc/shells | tail -1)

## ZSHRC
echo "--> Adding zshrc symlink"
cp $dir/zshrc $dir/zshrc_auto
ln -sf `pwd`/zsh ~/.zsh
ln -sf $dir/zshrc_auto ~/.zshrc

## BIN
echo "--> Adding bin to path"
echo 'export PATH='$bindir':$PATH' >> ~/.zshrc

# Python virtualenv
echo "Installing Python virtualenv"
sudo pip install virtualenv
pip install --user virtualenvwrapper
source ~/.zshrc

read -p "Would you like to set up Vim (Y/N)? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "Setting up Vim"
	brew install neovim/neovim/neovim > /dev/null 2>&1

	######### Make links

	## VIM
	echo "--> Adding Vim symlinks"
	ln -sf $dir/vimrc ~/.vimrc
	ln -sf $dir/vimrc $dir/.vim/init.vim
	ln -sf $dir/.vim ~

	# YCM conf
	cp $cpdir/ycm_extra_conf.py ~/.ycm_extra_conf

	# Python dependencies for syntastic.
	echo "	--> Installing Python dependencies"
	mkvirtualenv vim1 && workon vim1 && pip install pep8 autopep8 pyflakes neovim && deactivate vim

	# Install vim plugins and their dependencies.
	echo "	--> Installing Vundle"
	[ -e ~/.vim/bundle/Vundle.vim ] || git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
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

read -p "Would you like to set up Latexmk (Y/N)? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "--> Adding latexmk symlink"
	ln -sf $dir/latexmkrc ~/.latexmkrc
fi

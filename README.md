## What is this?

This repo contains my dotfiles and ansible plays for setting
up a developement environemnt with said dotfiles.

## What's included?

The ansible plays,

- Install Docker
- Install Go
- Install oh-my-zsh (and add my custom theme)
- Install Vim 8 and all of the packages referenced in the vimrc (including compiling YCM!)

Dotfiles include:

- Git
- vimrc (`roles/vim/templates/vimrc.j2`)
- zshrc (`roles/oh_my_zsh/templates/zshrc.j2`)

More to come.

## Installation

**NOTE:** Only Ubuntu 16.04 is supported as a development environment. Other
OSes should be easy to add support for with minor tweaking.

0) Install Ansible. Follow instructions [here](http://docs.ansible.com/ansible/latest/intro_installation.html).

1) To get started clone the repo:

	```bash
	git clone https://github.com/jholliman/dotfiles.git
	cd dotfiles
	```

2) Create an inventory file containing the machines you want to set. See
`inventory.sample` for an example inventory file or refer to the [documentation](http://docs.ansible.com/ansible/latest/intro_inventory.html).

3) Running the provisioning playbook (using an inventory file named `inventory`):

	```bash
	ansible-playbook -i inventory site.yml
	```
	This will take ~5-10 mins. After that, profit!

## Wait, you're not done!

For the best experience, do this:

- (If you're using iTerm) Download and install the [thayer colorscheme](https://github.com/baskerville/iTerm-2-Color-Themes/blob/master/thayer.itermcolors) 
- Download and install a [powerline patched font](https://github.com/powerline/fonts) 
- (If you use Go) Run `:GoInstallBinaries` first time you enter Vim

## TODOS

- [ ] Install patched font with Ansible
- [ ] Broaden OS support (Add Debain and OSX)
- [ ] Fix task for installing vim-go go binaries

`

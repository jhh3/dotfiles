.PHONY: all tmux vim git

all: tmux vim git
	@echo "Done =o="

tmux:
	cd tmux; make install

vim:
	cd vim; make install

git:
	cd git; make install

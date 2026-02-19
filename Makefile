## -*- mode: makefile-gmake -*-

OS:=$(shell uname -s)

dot:=$(CURDIR)
bin:=$(dot)/bin
tmp:=/tmp

.PHONY: install help symlinks scripts \
	playlists mpd.log mpd.db mpd.pid mpd.state

install: symlinks scripts

help:
	@echo "Usage: make [OPTION]"
	@echo "Makefile to configure user environment."
	@echo ""
	@echo "  make install     configure entire ~/. directory"
	@echo "  make symlinks    sync config files, en masse and platform specific"
	@echo "  make scripts     sync ~/bin and its scripts"
	@echo "  make help        display this message"
	@echo ""

symlinks-common: ackrc bash-aliases bash_profile bashrc \
	fasdrc flake8rc ghci git-aliases gitconfig gitignore_global inputrc \
	profile psqlrc sbclrc tmux.conf
		@echo "Symlinking common config files..."
		@for file in $^; do ln -fs $(dot)/$$file ~/.$$file; done
		@ln -fns $(dot)/tmux.d ~/.tmux.d

symlinks-linux: conkyrc-xmonad dunstrc inputrc xinitrc Xdefaults
		@echo "Symlinking Linux specific config files..."
		@for file in $^; do ln -fs $(dot)/$$file ~/.$$file; done

symlinks-osx: osx
		@echo "Symlinking OS X specific config files..."
		@for file in $^; do ln -fs $(dot)/$$file ~/.$$file; done

mpd-config: mpd.log mpd.db mpd.pid mpd.state
		@echo "Configuring mpd..."
		@mkdir -p ~/.mpd
		@mkdir -p ~/.mpd/playlists
		@mkdir -p ~/.ncmpcpp
		@mkdir -p ~/.mpdscribble
		@ln -fs $(dot)/mpd ~/.mpd/mpd.conf
		@ln -fs $(dot)/ncmpcpp ~/.ncmpcpp/config
		@ln -fs $(dot)/ncmpcpp_bindings ~/.ncmpcpp/bindings
		@ln -fs $(dot)/mpdscribble ~/.mpdscribble/mpdscribble.conf
		@for file in $^; do touch ~/.mpd/$$file; done
		@echo "Ensure your last.fm credentials are in mpdscribble.conf..."

vim-config:
		@echo "Configuring vim..."
		@ln -fns $(dot)/vim ~/.vim;
		@ln -fs $(dot)/vimrc ~/.vimrc
		@git -C $(dot) submodule update --init

ifeq ($(OS),Darwin)
symlinks: symlinks-common symlinks-osx mpd-config vim-config
else
symlinks: symlinks-common symlinks-linux mpd-config vim-config
endif

link-scripts:
		@if [ -d ~/bin ]; then rm -rf ~/bin; fi;
		@mkdir ~/bin
		@ln -s $(dot)/bin/* ~/bin/

scripts: link-scripts

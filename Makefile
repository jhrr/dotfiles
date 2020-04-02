## -*- mode: makefile-gmake -*-

OS:=$(shell uname -s)

dot:=$(CURDIR)
bin:=$(dot)/bin
tmp:=/tmp

pathogen_src=https://tpo.pe/pathogen.vim

vcp_ver=1.2.1
vep_src=https://www.github.com/jhrr/veprompt.git
vep_tmp=$(tmp)/veprompt

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
	@echo "  make vim         sync ~/.vim and update its plugins"
	@echo "  make help        display this message"
	@echo ""

symlinks-common: ackrc bash-aliases bash_profile bashrc ctags eslintrc \
	fasdrc flake8rc ghci git-aliases gitconfig gitignore_global inputrc \
	profile prompt psqlrc sbclrc tmux.conf
		@echo "Symlinking common config files..."
		@for file in $^; do ln -fs $(dot)/$$file ~/.$$file; done
		@ln -fns $(dot)/tmux.d ~/.tmux.d

symlinks-linux: conkyrc-xmonad dunstrc inputrc xinitrc Xdefaults
		@echo "Symlinking Linux specific config files..."
		@for file in $^; do ln -fs $(dot)/$$file ~/.$$file; done

symlinks-osx: osx
		@echo "Symlinking OS X specific config files..."
		@for file in $^; do ln -fs $(dot)/$$file ~/.$$file; done

git-template:
		# https://tbaggery.com/2011/08/08/effortless-ctags-with-git.html
		@echo "Symlinking git_template directory..."
		@ln -fns $(dot)/git_template ~/.git_template

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
		@mkdir -p ~/.vim-tmp
		@ln -fns $(dot)/vim ~/.vim;
		@ln -fs $(dot)/vimrc ~/.vimrc
		@echo "Installing pathogen..."
		@curl -LSso ~/.vim/autoload/pathogen.vim $(pathogen_src)
		@git -C $(dot) submodule update --init

update-vim-plugins:
		@git submodule foreach git pull --ff-only origin master

ifeq ($(OS),Darwin)
symlinks: symlinks-common symlinks-osx git-template mpd-config vim-config
else
symlinks: symlinks-common symlinks-linux git-template mpd-config vim-config
endif

update-veprompt:
		@echo "Getting veprompt source..."
		@git clone $(vep_src) $(vep_tmp)
		@echo "Installing veprompt in:"
		@echo $(bin)
		@$(MAKE) -C $(vep_tmp)
		@cp $(vep_tmp)/a.out $(bin)/veprompt
		@chmod a+x $(bin)/veprompt
		@rm -rf $(vep_tmp)

update-git-scripts:
		@if [ -d ~/code/oss/git-scripts ]; then \
			ln -fns ~/code/oss/git-scripts ~/bin/git-scripts; fi;

link-scripts:
		@if [ -d ~/bin ]; then rm -rf ~/bin; fi;
		@mkdir ~/bin
		@ln -s $(dot)/bin/* ~/bin/

scripts: update-git-scripts link-scripts

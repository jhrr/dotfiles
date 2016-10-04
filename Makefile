## -*- mode: makefile-gmake -*-

OS:=$(shell uname -s)

dot:=$(CURDIR)
bin:=$(dot)/bin
tmp:=/tmp

pathogen_src=https://tpo.pe/pathogen.vim

vcp_ver=1.2.1
vcp_dir=vcprompt-$(vcp_ver)
vcp_src=https://bitbucket.org/gward/vcprompt/downloads/$(vcp_dir).tar.gz
vcp_tmp=$(tmp)/$(vcp_dir)
vep_src=https://www.github.com/jhrr/veprompt.git
vep_tmp=$(tmp)/veprompt
z_src=https://github.com/rupa/z/raw/master/z.sh

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
	flake8rc ghci git-aliases gitconfig inputrc profile prompt psqlrc \
	sbclrc tmux.conf
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
		@mkdir -p ~/.ncmcpp
		@ln -fs $(dot)/mpd ~/.mpd/mpd.conf
		@ln -fs $(dot)/ncmcpp ~/.ncmcpp/config
		@for file in $^; do touch ~/.mpd/$$file; done

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
symlinks: symlinks-common symlinks-osx mpd-config vim-config
else
symlinks: symlinks-common symlinks-linux mpd-config vim-config
endif

update-vcprompt:
		@echo "Getting vcprompt source..."
		@curl -sL $(vcp_src) | tar -zx --directory=$(tmp)
		@echo "Compiling vcprompt..."
		@cd $(vcp_tmp) && ./configure CC=clang
		@echo "Installing vcprompt in:"
		@echo $(bin)
		@$(MAKE) -C $(vcp_tmp)
		@$(MAKE) -C $(vcp_tmp) install PREFIX=$(dot)
		@rm -rf $(dot)/man
		@rm -rf $(vcp_tmp)

update-veprompt:
		@echo "Getting veprompt source..."
		@git clone $(vep_src) $(vep_tmp)
		@echo "Installing vcprompt in:"
		@echo $(bin)
		@$(MAKE) -C $(vep_tmp)
		@cp $(vep_tmp)/a.out $(bin)/veprompt
		@chmod a+x $(bin)/veprompt
		@rm -rf $(vep_tmp)

update-z:
		@echo "Installing z.sh in:"
		@echo $(bin)
		@curl -sL $(z_src) > $(bin)/z
		@chmod a+x $(bin)/z

update-git-scripts:
		@if [ -d ~/code/oss/git-scripts ]; then \
			ln -fns ~/code/oss/git-scripts ~/bin/git-scripts; fi;

link-scripts:
		@if [ -d ~/bin ]; then rm -rf ~/bin; fi;
		@mkdir ~/bin
		@ln -s $(dot)/bin/* ~/bin/

scripts: update-vcprompt update-z update-git-scripts link-scripts

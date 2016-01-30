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
vep_src=https://github.com/jhrr/veprompt/raw/master/bin/veprompt
z_src=https://github.com/rupa/z/raw/master/z.sh

all: symlinks scripts

help:

symlinks-common: .ackrc .bash-aliases .bash_profile .bashrc .ctags .eslintrc \
	.flake8rc .ghci .git-aliases .gitconfig .profile .prompt .psqlrc .tmux.conf
		@for file in $^; do ln -fs $(dot)/$$file ~/$$file; done

symlinks-linux: .conkyrc-xmonad .dunstrc .inputrc .xinitrc .Xdefaults
		@for file in $^; do ln -fs $(dot)/$$file ~/$$file; done

symlinks-osx: .nix-aliases
		@for file in $^; do ln -fs $(dot)/$$file ~/$$file; done
		@mkdir -p ~/.nixpkgs
		@ln -fs $(dot)/config.nix ~/.nixpkgs/config.nix
		@if [ -d ~/code/oss/nixpkgs ] && [ -f ~/.nix-defexpr/channels ]; then \
			rm -rf ~/.nix-defexpr/channels; \
			ln -fns ~/code/oss/nixpkgs ~/.nix-defexpr/nixpkgs; fi;

vim:
		@mkdir -p ~/.vim-tmp
		@mkdir -p ~/.vim
		@mkdir -p ~/.vim/autoload ~/.vim/bundle
		@curl -LSso ~/.vim/autoload/pathogen.vim $(pathogen_src)
		@ln -fs $(dot)/.vimrc ~/.vimrc

ifeq ($(OS),'Darwin')
symlinks: symlinks-common symlinks-osx vim
else
symlinks: symlinks-common symlinks-linux vim
endif

update-vcprompt:
		@echo "Getting vcprompt source..."
		@curl -sL $(vcp_src) | tar -zx --directory=$(tmp)
		@echo "Compiling vcprompt..."
		@cd $(vcp_tmp) && ./configure CC=clang
		@$(MAKE) -C $(vcp_tmp)
		@echo "Installing vcprompt in:"
		@echo $(bin)
		@$(MAKE) -C $(vcp_tmp) install PREFIX=$(dot)
		@rm -rf $(dot)/man
		@rm -rf $(vcp_tmp)

update-veprompt:
		@echo "Installing veprompt in:"
		@echo $(bin)
		@curl -sL $(vep_src) > $(bin)/veprompt
		@chmod a+x $(bin)/veprompt

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

scripts: update-vcprompt update-veprompt update-z \
	update-git-scripts link-scripts

## -*- mode: makefile-gmake -*-

OS:=$(shell uname -s)

dot=$(CURDIR)
bin=$(dot)/bin
tmp=/tmp

vcp_ver=1.2.1
vcp_dir=vcprompt-$(vcp_ver)
vcp_src=https://bitbucket.org/gward/vcprompt/downloads/$(vcp_dir).tar.gz
vcp_tmp=$(tmp)/$(vcp_dir)
vep_src=https://github.com/jhrr/veprompt/raw/master/bin/veprompt
z_src=https://github.com/rupa/z/raw/master/z.sh

all: symlinks scripts

help:

# Something like this...
# objects = $(addprefix $(OBJDIR)/, kumain.o kudlx.o kusolvesk.o kugetpuz.o kuutils.o \
# 					  kurand.o kuASCboard.o kuPDFs.o kupuzstrings.o kugensud.o kushapes.o )

symlinks-common: .bash-aliases .bash_profile .bashrc .ctags .eslintrc .flake8rc \
	.ghci .git-aliases .gitconfig .profile .prompt .psqlrc .bash-aliases .tmux.conf
	    @for file in $^; do ln -fs $(dot)/$$file ${HOME}/$$file; done

symlinks-linux: .conkyrc-xmonad .dunstrc .inputrc .xinitrc
		@for file in $^; do ln -fs $(dot)/$$file ${HOME}/$$file; done

symlinks-osx: config.nix .nix-aliases
		@for file in $^; do ln -fs $(dot)/$$file ${HOME}/$$file; done

vim:
		@if [ -d ~/.vim-tmp ]; then rm -rf ~/.vim-tmp; fi;
		@mkdir ~/.vim-tmp
		@ln -fs $(dot)/.vimrc ~/.vimrc

ifeq ($(OS),'Darwin') 
symlinks: symlinks-common symlinks-osx vim
else
symlinks: symlinks-common symlinks-linux vim
endif

make-bin:
		@if [ -d ~/bin ]; then rm -rf ~/bin; fi;
		@mkdir ~/bin

update-vcprompt:
		curl -sL $(vcp_src) | tar -zx --directory=$(tmp)
		$(vcp_tmp)/configure CC=clang
		$(vcp_tmp)/make
		$(vcp_tmp)/make install PREFIX=$(dot)
		@rm -rf $(vcp_tmp)

update-veprompt:
		curl -sL $(vep_src) > $(bin)/veprompt
		@chmod a+x $(bin)/veprompt

update-z:
		curl -sL $(z_src) > $(bin)/z
		@chmod a+x $(bin)/z

update-git-scripts:
		@echo "Linking git-scripts/"
		@if [ -d ~/code/oss/git-scripts ]; then \
			ln -fns ~/code/oss/git-scripts ~/bin; fi;

link-scripts:
		@echo "Linking bin/"
		@if [ -d ~/bin ]; then rm -rf ~/bin; fi;
	    @ln -fns $(dot)/bin ~/bin

scripts: update-vcprompt update-veprompt update-z update-git-scripts \
	link-scripts


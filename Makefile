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
	    for file in $^; do ln -fs $(dot)/$$file ${HOME}/$$file; done

symlinks-linux: .conkyrc-xmonad .dunstrc .inputrc .xinitrc
		for file in $^; do ln -fs $(dot)/$$file ${HOME}/$$file; done

symlinks-osx: config.nix .nix-aliases
		for file in $^; do ln -fs $(dot)/$$file ${HOME}/$$file; done

vim:
		[ -d ~/.vim-tmp ] && rm -rf .vim-tmp
		mkdir ~/.vim-tmp
		ln -fs $(dot)/.vimrc ~/.vimrc

symlinks: symlinks-common
ifeq ($(OS),'Darwin')
		symlinks-osx
else
		symlinks-linux
endif
		vim

make-bin:
		[ -d ~/bin ] && rm -rf ~/bin
		mkdir ~/bin

update-vcprompt:
		curl -sL $(vcp_src) | tar -zx --directory=$(tmp)
		$(vcp_tmp)/configure
		$(vcp_tmp)/make
		$(vcp_tmp)/make install PREFIX=$(dot)
		# ln -fs $(bin)/vcprompt ~/bin/vcprompt
		rm -rf $(vcp_tmp)

update-veprompt:
		curl -sL $(vep_src) > $(bin)/veprompt
		chmod a+x $(bin)/veprompt
		# ln -fs $(bin)/veprompt ~/bin/veprompt

update-z:
		curl -sL $(z_src) > $(bin)/z
		chmod a+x $(bin)/z
		# ln -fs $(bin)/z ~/bin/z

update-git-scripts:
		@echo "Linking git-scripts/"
		[ -d ~/code/oss/git-scripts ] && ln -fns ~/code/oss/git-scripts ~/bin

link-scripts:
		@echo "Linking bin/"
		[ -d ~/bin ] && rm -rf ~/bin
	    ln -fns $(dot)/bin ~/bin

scripts: update-vcprompt update-veprompt update-z update-git-scripts \
	link-scripts


## -*- mode: makefile-gmake -*-

dot = $(CURDIR)
bin = $(dot)/bin
tmp = /tmp

vcp_ver = 1.2.1
vcp_dir = vcprompt-$(vcp_ver)
vcp_src = https://bitbucket.org/gward/vcprompt/downloads/$(vcp_dir).tar.gz
vcp_tmp = $(tmp)/$(vcp_dir)
vep_src = https://github.com/jhrr/veprompt/raw/master/bin/veprompt
z_src = https://github.com/rupa/z/raw/master/z.sh

all:

help:

symlinks-common:
				mkdir ~/.vim-tmp
			 	ln -fs $(dot)/.bash-aliases ~/.bash-aliases
			 	ln -fs $(dot)/.bash_profile ~/.bash_profile
			 	ln -fs $(dot)/.bashrc ~/.bashrc
			 	ln -fs $(dot)/.ctags ~/.ctags
			 	ln -fs $(dot)/.eslintrc ~/.eslintrc
			 	ln -fs $(dot)/.flake8rc ~/.flake8rc
			 	ln -fs $(dot)/.ghci ~/.ghci
			 	ln -fs $(dot)/.git-aliases ~/.git-aliases
			 	ln -fs $(dot)/.gitconfig ~/.gitconfig
			 	ln -fs $(dot)/.profile ~/.profile
			 	ln -fs $(dot)/.prompt ~/.prompt
			 	ln -fs $(dot)/.psqlrc ~/.psqlrc
			 	ln -fs $(dot)/.sbclrc ~/.bash-aliases
			 	ln -fs $(dot)/.tmux.conf ~/.tmux.conf

symlinks-linux:
			 	ln -fs $(dot)/.conkyrc-xmonad ~/.conkyrc-xmonad
			 	ln -fs $(dot)/.dunstrc ~/.dunstrc
			 	ln -fs $(dot)/.inputrc ~/.inputrc
			 	ln -fs $(dot)/.xinitrc ~/.xinitrc

symlinks-osx:
			 	ln -fs $(dot)/config.nix ~/.nixpkgs/config.nix
			 	ln -fs $(dot)/.nix-aliases ~/.nix-aliases
				
vim:
				[ -d ~/.vim-tmp ] && rm -rf .vim-tmp
				mkdir ~/.vim-tmp
				ln -fs $(dot)/.vimrc ~/.vimrc

symlinks:
				# symlinks-common if osx: symlinks-osx else: symlinks-linux

make-bin:
				[ -d ~/bin ] && rm -rf ~/bin
				mkdir ~/bin

update-vcprompt :
				curl -sL $(vcp_src) | tar -zx --directory=$(tmp)
				$(vcp_tmp)/configure
				$(vcp_tmp)/make
				$(vcp_tmp)/make install PREFIX=$(dot)
				ln -fs $(bin)/vcprompt ~/bin/vcprompt
				rm -rf $(vcp_tmp)

update-veprompt :
				curl -sL $(vep_src) > $(bin)/veprompt
				chmod a+x $(bin)/veprompt
				ln -fs $(bin)/veprompt ~/bin/veprompt

update-z :
				curl -sL $(z_src) > $(bin)/z
				chmod a+x $(bin)/z
				ln -fs $(bin)/z ~/bin/z

update-git-scripts :
				@echo "Need to do git scripts"

link-scripts:
				@echo "Need to link contents of bin"
				# loop over all files and ln -fs

scripts: make-bin update-vcprompt update-veprompt update-z \
	update-git-scripts link-scripts


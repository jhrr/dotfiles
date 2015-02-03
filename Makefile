## -*- mode: makefile-gmake -*-

dot = $(CURDIR)
bin = $(dot)/bin
tmp = /tmp

mkdir $(bin)

# rm ~/.vimrc
# mkdir ~/.vim-tmp
# ln -s $(dot)/.vimrc ~/.vimrc

# Prompt scripts
vcp_ver = 1.2.1
vcp_dir = vcprompt-$(vcp_ver)
vcp_src = https://bitbucket.org/gward/vcprompt/downloads/$(vcp_dir).tar.gz
vcp_tmp = $(tmp)/$(vcp_dir)
vep_src = https://github.com/jhrr/veprompt/raw/master/bin/veprompt

update-vcprompt :
        curl -sL $(vcp_src) | tar -zx --directory=$(tmp)
        $(vcp_tmp)/configure
        $(vcp_tmp)/make
        $(vcp_tmp)/make install PREFIX=$(dot)
        ln -s $(vcp_tmp)/vcprompt ~/bin/vcprompt
        rm -rf $(vcp_tmp)

update-veprompt :
        curl -sL $(vep_src) > $(bin)/veprompt
        chmod +x $(bin)/veprompt
        ln -s $(bin)/veprompt ~/bin/veprompt

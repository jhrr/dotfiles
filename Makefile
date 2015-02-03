## -*- mode: makefile-gmake -*-

dot = $(CURDIR)
bin = $(dot)/bin
tmp = $(dot)/tmp

mkdir $(bin)
mkdir $(tmp)

# rm ~/.vimrc
# mkdir ~/.vim-tmp
# ln -s $(dot)/.vimrc ~/.vimrc

vcp_ver = 1.2.1
vcp_src = https://bitbucket.org/gward/vcprompt/downloads/vcprompt-$(vcp_ver).tar.gz
vep_src = https://github.com/jhrr/veprompt/raw/master/bin/veprompt

update-vcprompt :
        curl -L $(vcp_src) | tar -zx -C $(tmp)
        $(tmp)/vcprompt-$(ver)/configure
        $(tmp)/vcprompt-$(ver)/make
        $(tmp)/vcprompt-$(ver)/make install PREFIX=$(CURDIR)
        ln -s $(tmp)/vcprompt-$(ver)/vcprompt ~/bin/vcprompt
        rm -rf $(tmp)/vcprompt-$(ver)

update-veprompt :
        curl -sL $(vep_src) > $(bin)/veprompt
        chmod +x $(bin)/veprompt
        ln -s $(bin)/veprompt ~/bin/veprompt

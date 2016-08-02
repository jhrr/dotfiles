# -*- mode: sh; -*-
# vi: set ft=sh :

if [[ -r ~/.profile ]]; then
  . ~/.profile;
fi

case "$-" in
  *i*)
    if [[ -r ~/.bashrc ]]; then
      . ~/.bashrc;
    fi;;
esac


test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

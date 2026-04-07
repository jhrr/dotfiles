# -*- mode: sh; -*-
# vi: set ft=sh :

if [ -r ~/.profile ]; then
  . ~/.profile;
fi

case "$-" in
  *i*)
    if [ -r ~/.bashrc ]; then
      . ~/.bashrc;
    fi;;
esac

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi

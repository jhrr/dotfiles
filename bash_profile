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

if command -v fasd >/dev/null 2>&1; then
  fasd_cache="${HOME}/.fasd-init-bash"
  if [ -n "$(find -L "$(command -v fasd)" -prune -newer "${fasd_cache}")" ] \
    || [ ! -s "${fasd_cache}" ]; then
      fasd --init \
        posix-alias \
        bash-hook \
        bash-ccomp \
        bash-ccomp-install \
        >| "${fasd_cache}"
  fi
  . "${fasd_cache}"
  unset fasd_cache
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi

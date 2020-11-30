# -*- mode: sh; -*-
# vi: set ft=sh :

umask 0022

PATH="$PATH:/usr/local/bin:/usr/bin"
PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"

[ -d "${HOME}/bin" ] &&
  PATH="$PATH:${HOME}/bin"

[ -d "${HOME}/.cabal/bin" ] &&
  PATH="$PATH:${HOME}/.cabal/bin"

[ -d "${HOME}/.cargo/bin" ]
  PATH="$HOME/.cargo/bin:$PATH"

[ -d "${HOME}/cdpr7/_cdp/_cdprogs" ] &&
  PATH="${HOME}/cdpr7/_cdp/_cdprogs:$PATH"

[ "$(uname -s)" = Darwin ] &&
  PATH="$PATH:/usr/local/bin"

if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

if [ -d /etc/profile.d/ ]; then
  for profile in /etc/profile.d/*.sh; do
    [ -r "${profile}" ] &&
      . "${profile}"
  done
  unset profile
fi

# Usage: puniq [<path>]
# Remove duplicate entries from a PATH style value, retaining the
# original order. Non-destructive; use assignment capture.
puniq() {
  echo "$1" | tr : '\n' | nl | sort -u -k 2,2 | sort -n \
    | cut -f 2- | tr '\n' : | sed -e 's/:$//' -e 's/^://'
}
PATH="$(puniq "$PATH")"
export PATH

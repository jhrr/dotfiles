# -*- mode: sh; -*-
# vi: set ft=sh :

umask 0022

[ -d "${HOME}/bin" ] &&
  PATH="$PATH:${HOME}/bin"

# shellcheck disable=SC1091
[ -f "${HOME}/.cargo/env" ] &&
  . "${HOME}/.cargo/env"

if [ "$(hostname)" = 'paradise' ]; then
  [ -f "${HOME}/.prompt" ] &&
    . "${HOME}/.prompt"
else
  if command -v 'starship' >/dev/null 2>&1; then
    eval "$(starship init bash)"
    export STARSHIP_CONFIG=~/code/src/dotfiles/starship.toml
  fi
fi

if command -v 'pyenv' >/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
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

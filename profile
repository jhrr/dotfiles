# -*- mode: sh; -*-
# vi: set ft=sh :

umask 0022

[ -d "${HOME}/bin" ] &&
  PATH="$PATH:${HOME}/bin:${HOME}/.local/bin"

# shellcheck disable=SC1091
[ -f "${HOME}/.cargo/env" ] &&
  . "${HOME}/.cargo/env"

# shellcheck disable=SC1091
[ -f "$HOME/.local/bin/env" ] &&
  . "$HOME/.local/bin/env"

# shellcheck disable=SC1091
[ -f "${HOME}/.prompt" ] &&
  . "${HOME}/.prompt"

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

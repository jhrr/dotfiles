[ -L "$HOME/.nix-profile" ] && {
  . "$HOME/.nix-profile/etc/profile.d/nix.sh"
  export NIXPKGS_PATH="${HOME}/code/oss/nixpkgs"
  export NIX_PATH=nixpkgs="${NIXPKGS_PATH}"
}

[[ "${IS_OSX}" == false ]] && {
  PATH="$PATH:/usr/local/bin"
  PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"
}

[ -d "$HOME/bin" ] &&
  PATH="$PATH:$HOME/bin"
[ -d "$HOME/.cabal/bin" ] &&
  PATH="$PATH:$HOME/.cabal/bin"
[ -d "/usr/lib/smlnj" ] && {
  PATH="$PATH:/usr/lib/smlnj/bin"
  export SMLNJ_HOME="/usr/lib/smlnj"
}

[ -L "$HOME/bin/git-scripts" ] &&
  PATH="$PATH:$HOME/bin/git-scripts/"

# Usage: puniq [<path>]
# Remove duplicate entries from a PATH style value, retaining the
# original order. Non-destructive; use assignment capture.
puniq() {
  echo "$1" | tr : '\n' | nl | sort -u -k 2,2 | sort -n \
    | cut -f 2- | tr '\n' : | sed -e 's/:$//' -e 's/^://'
}
PATH="$(puniq "$PATH")"
export PATH

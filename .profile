[ -L "${HOME}/.nix-profile" ] && {
  . "${HOME}/.nix-profile/etc/profile.d/nix.sh"
  NIXPKGS_PATH="${HOME}/code/oss/nixpkgs"
  NIX_PATH=nixpkgs="${NIXPKGS_PATH}"
  export NIXPKGS_PATH NIX_PATH
}

[ "${IS_OSX}" == false ] && {
  PATH="$PATH:/usr/local/bin"
  PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"
  [ -d "/usr/lib/smlnj" ] && {
    PATH="$PATH:/usr/lib/smlnj/bin"
    SMLNJ_HOME="/usr/lib/smlnj"
    export SMLNJ_HOME
  }
}

[ -d "${HOME}/bin" ] &&
  PATH="$PATH:${HOME}/bin"
[ -d "${HOME}/.cabal/bin" ] &&
  PATH="$PATH:${HOME}/.cabal/bin"

[ -L "${HOME}/bin/git-scripts" ] &&
  PATH="$PATH:${HOME}/bin/git-scripts/"

# Usage: puniq [<path>]
# Remove duplicate entries from a PATH style value, retaining the
# original order. Non-destructive; use assignment capture.
puniq() {
  echo "$1" | tr : '\n' | nl | sort -u -k 2,2 | sort -n \
    | cut -f 2- | tr '\n' : | sed -e 's/:$//' -e 's/^://'
}
PATH="$(puniq "$PATH")"
export PATH

PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"
PATH="/usr/local/bin:$PATH"

[ -d ~/bin ] &&
  PATH=~/bin:$PATH
[ -d ~/.cabal/bin ] &&
  PATH=~/.cabal/bin:$PATH
[ -d /usr/lib/smlnj ] && {
  PATH=/usr/lib/smlnj/bin:$PATH
  export SMLNJ_HOME=/usr/lib/smlnj
}

# Usage: puniq [<path>]
# Remove duplicate entries from a PATH style value, retaining the
# original order. Non-destructive; use assignment capture.
puniq() {
  echo "$1" | tr : '\n' | nl | sort -u -k 2,2 | sort -n \
    | cut -f 2- | tr '\n' : | sed -e 's/:$//' -e 's/^://'
}
PATH="$(puniq "$PATH")"
export PATH

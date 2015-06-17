PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"
PATH="/usr/local/bin:$PATH"

[ -d "$HOME/bin" ] &&
  PATH="$PATH:$HOME/bin"
[ -d "$HOME/.cabal/bin" ] &&
  PATH="$PATH:$HOME/.cabal/bin"
[ -d "/usr/lib/elixir/bin/" ] &&
  PATH="$PATH:/usr/lib/elixir/bin/"
[ -d "/usr/lib/smlnj" ] && {
  PATH="$PATH:/usr/lib/smlnj/bin"
  export SMLNJ_HOME="/usr/lib/smlnj"
}
[ -d "$HOME/code/repos/git-scripts" ] &&
  PATH="$HOME/code/repos/git-scripts:$PATH"
[ -d "$HOME/code/repos/vcprompt/bin" ] &&
  PATH="$HOME/code/repos/vcprompt/bin:$PATH"

# Usage: puniq [<path>]
# Remove duplicate entries from a PATH style value, retaining the
# original order. Non-destructive; use assignment capture.
puniq() {
  echo "$1" | tr : '\n' | nl | sort -u -k 2,2 | sort -n \
    | cut -f 2- | tr '\n' : | sed -e 's/:$//' -e 's/^://'
}
PATH="$(puniq "$PATH")"
export PATH

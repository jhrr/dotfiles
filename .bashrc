# TODO: ls defaults
# TODO: TMUX -- https://wiki.archlinux.org/index.php/tmux#Start_tmux_on_every_shell_login

[[ -f /etc/bashrc ]] &&
  . /etc/bashrc

: "${HOME=~}"
: "${LOGNAME=$(id -un)}"
: "${UNAME=$(uname)}"
: "${HOSTFILE=~/.ssh/known_hosts}"
: "${INPUTRC=~/.inputrc}"

: "${LANG:="en_GB.UTF-8"}"
: "${LANGUAGE:="en"}"
: "${LC_CTYPE:="en_GB.UTF-8"}"
: "${LC_ALL:="en_GB.UTF-8"}"
export LANG LANGUAGE LC_CTYPE LC_ALL

ulimit -S -c 0
umask 0022

shopt -s cdspell >/dev/null 2>&1
shopt -s extglob >/dev/null 2>&1
shopt -s histappend >/dev/null 2>&1
shopt -s hostcomplete >/dev/null 2>&1
shopt -s interactive_comments >/dev/null 2>&1
shopt -s no_empty_cmd_completion >/dev/null 2>&1
shopt -u mailwarn >/dev/null 2>&1

set -o emacs
set -o notify
unset MAILCHECK

PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"
PATH="/usr/local/bin:$PATH"

[[ -d ~/bin ]] &&
  PATH=~/bin:$PATH
[[ -d ~/.cabal/bin ]] &&
  PATH=~/.cabal/bin:$PATH
[[ -d /usr/lib/smlnj ]] && {
  PATH=/usr/lib/smlnj/bin:$PATH
  export SMLNJ_HOME=/usr/lib/smlnj
}

HISTCONTROL=ignoreboth,erasedups
HISTIGNORE="&:l:ls:ll:cd:exit:clear:history:h"
HISTFILESIZE=10000
HISTSIZE=10000

_islinux=false
[[ "$(uname -s)" =~ Linux|GNU|GNU/* ]] &&
  _islinux=true

_isfreebsd=false
[[ "$(uname -s)" =~ FreeBSD ]] &&
  _isfreebsd=true

_withx=false
[[ "$DISPLAY" ]] &&
  _withx=true

editors="emacs:vim:vi"
browsers="elinks:lynx:links"
xbrowsers="chromium:firefox:uzbl"

_set_preferred() {
  local IFS=":" var=$1 list=$2 item
  for item in $list; do
    program="$(which "$item" 2>/dev/null)"
    if [[ -x "$program" ]]; then
      printf -v "$var" %s "$program"
      break
    fi
  done
}
_set_preferred "EDITOR" $editors
if [[ "$_withx" =~ true ]]; then
  _set_preferred "BROWSER" $xbrowsers
else
  _set_preferred "BROWSER" $browsers
fi

HAVE_VIM=$(command -v vim)
if [[ -x "$HAVE_VIM" ]]; then
  VISUAL=vim
else
  VISUAL=vi
fi
export VISUAL

HAVE_LESS=$(command -v less)
if [[ -x "$HAVE_LESS" ]]; then
    PAGER="less -FirSwX"
    MANPAGER="less -FiRswX"
else
    PAGER=more
    MANPAGER="$PAGER"
fi
export PAGER MANPAGER

[[ -f ~/bin/vcprompt ]] &&
  export VCPROMPT_FORMAT="[%b:%n:%r]"
[[ -f ~/bin/veprompt ]] &&
  export VIRTUAL_ENV_DISABLE_PROMPT=1

[[ -f /usr/bin/virtualenvwrapper.sh ]] && {
  . /usr/bin/virtualenvwrapper.sh
  export WORKON_HOME=~/.virtualenvs
  export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7
}

[[ -f ~/.git-completion.sh ]]
. ~/.git-completion.sh

[[ -f /etc/bash_completion.d/password-store ]] &&
  . /etc/bash_completion.d/password-store

[[ -f ~/.bash_aliases ]] &&
  . ~/.bash_aliases

if pgrep 'gpg-agent'; then
  eval "$(gpg-agent --daemon)"
fi

eval "$(keychain --eval --agents ssh -Q --quiet jhrr_id_rsa cmg_id_rsa)"

# Usage: puniq [<path>]
# Remove duplicate entries from a PATH style value and retaining
# the original order. Non-destructive; use assignment capture.
puniq() {
    echo "$1" | tr : '\n' | nl |sort -u -k 2,2 | sort -n |
    cut -f 2- | tr '\n' : | sed -e 's/:$//' -e 's/^://'
}
PATH="$(puniq "$PATH")"

PS1="${YELLOW}\u${BLUE}@${YELLOW}\h${BLUE}(${YELLOW}\w${BLUE})\
${Cyan}\$(veprompt -f '[%v:%n]' -t)\
${GREEN}\$(vcprompt -f '[%n:%b]')${WHITE}\$(vcprompt -f '%u %m')\
${RED}\n\
${BIPurple}\$${LIGHT_GREY} "

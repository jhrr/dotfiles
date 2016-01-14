# -*- mode: sh; -*-

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

HISTCONTROL=ignoreboth,erasedups
HISTIGNORE="&:l:ls:ll:cd:exit:clear:pwd:history:h:#*"
HISTFILESIZE=10000
HISTSIZE=10000

IS_LINUX=false
[[ "$(uname -s)" =~ Linux|GNU|GNU/* ]] && {
  IS_LINUX=true
  export IS_LINUX
}

IS_OSX=false
[[ "$(uname -s)" =~ Darwin ]] && {
  IS_OSX=true
  export IS_OSX
}

IS_FREEBSD=false
[[ "$(uname -s)" =~ FreeBSD ]] && {
  IS_FREEBSD=true
  export IS_FREEBSD
}

editors="vim:vi:emacs"
browsers="elinks:lynx:links"
xbrowsers="chromium:firefox:uzbl"

_set_preferred() {
  local IFS=":" var="$1" list="$2" item
  for item in $list; do
    program="$(command -v "${item}" 2>/dev/null)"
    if [[ -x "${program}" ]]; then
      printf -v "${var}" %s "${program}"
      break
    fi
  done
}

_set_preferred "VISUAL" $editors
HAVE_VIM=$(command -v vim)
if [[ -x "${HAVE_VIM}" ]]; then
  EDITOR=vim
else
  EDITOR=vi
fi
export VISUAL EDITOR

HAVE_LESS=$(command -v less)
if [[ -x "${HAVE_LESS}" ]]; then
  PAGER="less -FirSwX"
  MANPAGER="less -FiRswX"
else
  PAGER=more
  MANPAGER="${PAGER}"
fi
export PAGER MANPAGER

[[ "${IS_LINUX}" == true ]] && {
  if [[ "${DISPLAY}" == true ]]; then
    _set_preferred "BROWSER" $xbrowsers
  else
    _set_preferred "BROWSER" $browsers
  fi
  export BROWSER
} 

[[ -f /usr/bin/virtualenvwrapper.sh ]] && {
  . /usr/bin/virtualenvwrapper.sh
  export WORKON_HOME=~/.virtualenvs
  # export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7
}

[[ -f ~/bin/git-completion ]] &&
  . ~/bin/git-completion

[[ -f /etc/bash_completion.d/password-store ]] &&
  . /etc/bash_completion.d/password-store

[[ -f ~/.bash-aliases ]] &&
  . ~/.bash-aliases
[[ -f ~/.git-aliases ]] &&
  . ~/.git-aliases
[[ -f ~/.nix-aliases ]] &&
  . ~/.nix-aliases

[[ -f ~/.prompt ]] && {
  . ~/.prompt
  # export VIRTUAL_ENV_DISABLE_PROMPT=1
}

if pgrep 'gpg-agent'; then
  eval "$(gpg-agent --daemon)"
fi

[[ "${IS_OSX}" == true ]] &&
  export GREP_OPTIONS='--color=auto'

eval "$(keychain --eval --agents ssh -Q --quiet jhrr_id_rsa cmg_id_rsa)"

# -*- mode: sh; -*-
# vi: set ft=sh :

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
unset MANPATH
unset TERMCAP

HISTCONTROL=ignoreboth:ignoredups:erasedups
HISTIGNORE="&:l:ls:ll:cd:exit:clear:pwd:history:h:#*"
HISTFILESIZE=10000
HISTSIZE=10000

IS_LINUX=false
[[ "$(uname -s)" =~ Linux|GNU|GNU/* ]] && IS_LINUX=true
export IS_LINUX

IS_OSX=false
[[ "$(uname -s)" =~ Darwin ]] && IS_OSX=true
export IS_OSX

IS_FREEBSD=false
[[ "$(uname -s)" =~ FreeBSD ]] && IS_FREEBSD=true
export IS_FREEBSD

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

editors="vim:vi:emacs"
browsers="elinks:lynx:links"
xbrowsers="chromium:firefox:uzbl"
greppage="ack:grep"

_set_preferred "VISUAL" $editors
_set_preferred "EDITOR" $editors
_set_preferred "GREPPAGE" $greppage
[[ "${IS_LINUX}" == true ]] && {
  if [[ "${DISPLAY}" == true ]]; then
    _set_preferred "BROWSER" $xbrowsers
  else
    _set_preferred "BROWSER" $browsers
  fi
  export BROWSER
}
export VISUAL EDITOR GREPPAGE

if command -v less >/dev/null 2>&1; then
  LESS="less -FirSwX"
  PAGER="${LESS}"
  MANPAGER="${PAGER}"
else
  PAGER=more
  MANPAGER="${PAGER}"
fi
export LESS PAGER MANPAGER

if [[ -f /usr/bin/virtualenvwrapper.sh ]]; then
  . /usr/bin/virtualenvwrapper.sh
elif [[ -f "${HOME}"/.nix-profile/bin/virtualenvwrapper.sh ]]; then
  . "${HOME}/.nix-profile/bin/virtualenvwrapper.sh"
fi
WORKON_HOME=~/.virtualenvs
VIRTUAL_ENV_DISABLE_PROMPT=1
export WORKON_HOME VIRTUAL_ENV_DISABLE_PROMPT

[[ -r /usr/share/bash-completion/bash_completion ]] &&
  . /usr/share/bash-completion/bash_completion
[[ -f /etc/bash_completion.d/password-store ]] &&
  . /etc/bash_completion.d/password-store
[[ -f ~/bin/fabric-completion ]] &&
  . ~/bin/fabric-completion
[[ -f ~/bin/git-completion ]] &&
  . ~/bin/git-completion

[[ -f ~/.bash-aliases ]] &&
  . ~/.bash-aliases
[[ -f ~/.git-aliases ]] &&
  . ~/.git-aliases
[[ -f ~/.nix-aliases ]] &&
  . ~/.nix-aliases

[[ -f ~/.prompt ]] &&
  . ~/.prompt

[[ -f ~/bin/z ]] &&
  . ~/bin/z

start_mpd() {
  if command -v 'mpd' >/dev/null 2>&1; then
    if ! pgrep -xU "${UID}" 'mpd' >/dev/null 2>&1; then
      [[ -f "${HOME}/.mpd/mpd.conf" ]] &&
        mpd "${HOME}/.mpd/mpd.conf"
      # Make sure the scrobbler is running if we are starting mpd.
      # TODO: we also start these in xinit. That could use a refactor.
      if command -v 'mpdscribble' >/dev/null 2>&1; then
        if ! pgrep -xU "${UID}" 'mpdscribble' >/dev/null 2>&1; then
          [[ -f "${HOME}/.mpdscribble/mpdscribble.conf" ]] &&
            "mpdscribble --conf ${HOME}/.mpdscribble/mpdscribble.conf &"
        fi
      fi
    fi
  fi
}

# TODO: At some point we want to develop and merge this colourscheme with the
# settings in Xdefaults for linux and bsd.
[[ "${IS_OSX}" == true ]] && {
  [[ -f ~/.osx ]] && . ~/.osx

  _ls_colors='fi=00;00:'     # file
  _ls_colors+='pi=04;91:'    # fifo
  _ls_colors+='so=00;95:'    # socket
  _ls_colors+='ln=00;32:'    # symlink
  _ls_colors+='di=00;94:'    # directory
  _ls_colors+='ex=00;31:'    # executable
  _ls_colors+='bd=04;93:'    # block special
  _ls_colors+='cd=00;93:'    # character special
  _ls_colors+='or=07;31:'    # symlink to non-existent file
  _ls_colors+='*.gz=01;31:'
  _ls_colors+='*.tar=01;31:'
  _ls_colors+='*.tgz=01;31:'
  _ls_colors+='*.tbz=01;31:'
  _ls_colors+='*.zip=01;31:'
  _ls_colors+='*.org=01;93:'

  LS_COLORS="${_ls_colors}"
  CC="$(command -v clang)"
  export LS_COLORS CC

  # if pgrep 'tmux'; then
    # [[ -f ~/.tmux.conf ]] &&
      # tmux source ~/.tmux.conf
  # fi

  # start_mpd;
}

SHELLCHECK_OPTS="-e SC1090,SC1091"
export SHELLCHECK_OPTS

if command -v 'gpg-agent' >/dev/null 2>&1; then
  if ! pgrep -xU "${UID}" 'gpg-agent' >/dev/null 2>&1; then
    eval "$(gpg-agent --daemon)"
  fi
fi
if command -v 'keychain' >/dev/null 2>&1; then
  eval "$(keychain --eval --agents ssh -Q --quiet jhrr_id_rsa cmg_id_rsa)"
fi

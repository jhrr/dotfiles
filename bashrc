# shellcheck shell=bash
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
unset TERMCAP

HISTIGNORE="&:l:ls:ll:cd:exit:clear:pwd:history:h:#*"
HISTSIZE=
HISTFILESIZE=
HISTCONTROL=ignoredups:erasedups
PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"
shopt -s histappend
export HISTCONTROL HISTIGNORE HISTSIZE HISTFILESIZE PROMPT_COMMAND

IS_LINUX=false
[[ "$(uname -s)" =~ Linux|GNU|GNU/* ]] && IS_LINUX=true
export IS_LINUX

IS_OSX=false
[[ "$(uname -s)" =~ Darwin ]] && IS_OSX=true
export IS_OSX

IS_FREEBSD=false
[[ "$(uname -s)" =~ FreeBSD ]] && IS_FREEBSD=true
export IS_FREEBSD

[[ "${IS_OSX}" == true ]] && {
  [[ -f ~/.osx ]] && . ~/.osx

  architecture="$(uname -m)"

  if [ "${architecture}" = "x86_64" ]; then
    export BREW_PREFIX='/usr/local'
    eval "$(/usr/local/bin/brew shellenv)"
  else
    export BREW_PREFIX='/opt/homebrew'
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  if ! grep -F -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
    echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
    chsh -s "${BREW_PREFIX}/bin/bash";
  fi;

  _ls_colors='fi=00;00:'   # file
  _ls_colors+='pi=04;91:'  # fifo
  _ls_colors+='so=00;95:'  # socket
  _ls_colors+='ln=00;32:'  # symlink
  _ls_colors+='di=00;94:'  # directory
  _ls_colors+='ex=00;31:'  # executable
  _ls_colors+='bd=04;93:'  # block special
  _ls_colors+='cd=00;93:'  # character special
  _ls_colors+='or=07;31:'  # symlink to non-existent

  _ls_colors+='*.gz=01;31:'
  _ls_colors+='*.tar=01;31:'
  _ls_colors+='*.tgz=01;31:'
  _ls_colors+='*.tbz=01;31:'
  _ls_colors+='*.zip=01;31:'
  _ls_colors+='*.org=01;93:'

  LS_COLORS="${_ls_colors}"
  CC="$(command -v clang)"
  export LS_COLORS CC

  # shellcheck disable=SC1091
  [[ -f "${BREW_PREFIX}/etc/profile.d/bash_completion.sh" ]] &&
    . "${BREW_PREFIX}/etc/profile.d/bash_completion.sh"

  [[ -d "${BREW_PREFIX}/etc/bash_completion.d/" ]] &&
    for f in "${BREW_PREFIX}"/etc/bash_completion.d/*; do . "${f}"; done

  [[ -f ~/.iterm2_shell_integration.bash ]] &&
    . ~/.iterm2_shell_integration.bash

  PATH="${BREW_PREFIX}/opt/gawk/libexec/gnubin:$PATH"
  PATH="${BREW_PREFIX}/opt/gsed/libexec/gnubin:$PATH"

  if [[ $ITERM_SESSION_ID ]]; then
    export DISABLE_AUTO_TITLE="true"
    # Sets the tab title to current dir.
    export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}$(__git_ps1 :%s)\007"'
  fi

}

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
greppage="rg:ack:grep"

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
  LESS="-FiRswX"
  PAGER="less"
  MANPAGER="${PAGER}"
  export LESS PAGER MANPAGER
else
  PAGER="more"
  MANPAGER="${PAGER}"
  export PAGER MANPAGER
fi

SHELLCHECK_OPTS="-e SC1090,SC1092,SC2148"
export SHELLCHECK_OPTS

WORKON_HOME="${HOME}/.virtualenvs"
PIP_REQUIRE_VIRTUALENV=true
VIRTUAL_ENV_DISABLE_PROMPT=1
export WORKON_HOME PIP_REQUIRE_VIRTUALENV VIRTUAL_ENV_DISABLE_PROMPT

[[ -f ~/.bash-aliases ]] &&
  . ~/.bash-aliases
[[ -f ~/.git-aliases ]] &&
  . ~/.git-aliases
[[ -f ~/.nix-aliases ]] &&
  . ~/.nix-aliases
[[ -f ~/.private ]] &&
  . ~/.private

[[ -f ~/.fzf.bash ]] &&
  . ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "${BREW_PREFIX}/opt/nvm/nvm.sh" ] && \
  . "${BREW_PREFIX}/opt/nvm/nvm.sh"
[ -s "${BREW_PREFIX}/opt/nvm/etc/bash_completion.d/nvm" ] && \
  . "${BREW_PREFIX}/opt/nvm/etc/bash_completion.d/nvm"

mpd-start() {
  if command -v 'mpd' >/dev/null 2>&1; then
    if ! pgrep -xU "${UID}" 'mpd' >/dev/null 2>&1; then
      [[ -f "${HOME}/.mpd/mpd.conf" ]] && {
        mpd "${HOME}/.mpd/mpd.conf" -v
        # Make sure the scrobbler is running if we are starting mpd.
        if command -v 'mpdscribble' >/dev/null 2>&1; then
          if ! pgrep -xU "${UID}" 'mpdscribble' >/dev/null 2>&1; then
            [[ -f "${HOME}/.mpdscribble/mpdscribble.conf" ]] &&
              mpdscribble --conf "${HOME}/.mpdscribble/mpdscribble.conf" &
          fi
        fi
      }
    fi
  fi
}
mpd-start

mpd-restart() {
  mpd --kill && mpd-start
}

if command -v 'gpg-agent' >/dev/null 2>&1; then
  if ! pgrep -xU "${UID}" 'gpg-agent' >/dev/null 2>&1; then
    eval "$(gpg-agent --daemon)"
  fi
fi

[[ "${IS_LINUX}" == true ]] && {
  if command -v 'keychain' >/dev/null 2>&1; then
    eval "$(keychain --eval --agents ssh -Q --quiet jhrr_id_rsa cmg_id_rsa)"
  fi
}

# -*- mode: sh; -*-

alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias delpyc='find . -name "*.pyc" -exec rm -rf {} \;'
alias du='du -h -c'
alias du1='du -h --max-depth=1'
alias ea='ec $HOME/dotfiles/'
alias exm='ec $HOME/.xmonad/xmonad.hs'
alias g='ack -i'
alias grd='ls -aliF | ack -i'
alias h='history | grep -i'
alias kcC='keychain --clear'  # safely decache keychain keys
alias lift='sudo $(history -p \!\!)'  # sudo previous command
alias myip='curl --silent http://tnx.nl/ip; printf "\n"'
alias open='xdg-open &>/dev/null'
alias p='ping -c 5 8.8.8.8'
alias ping='ping -c 5'
alias psql='sudo -i -u postgres psql'
alias py='ipython'
alias rms='reset; python manage.py runserver_plus localhost:8001'
alias shclr='msgcat --color=test'
alias shred='shred -zuv'
alias reload='. $HOME/.bash_profile'
alias tv1='xset s off && xset -dpms && echo "screen powersaving off..."'
alias tv0='xset s default && xset +dpms && echo "screen powersaving on..."'
alias txa='tmux attach'
alias txd='tmux detach'
alias txl='tmux ls'
alias txn='tmux attach -t'
alias txs='tmux switch -t'
alias x='startx'
alias vssh='vagrant ssh'

alias sue='sudo emacs -nw'
alias v='\$VISUAL'
alias suv='sudo \$VISUAL'

# Usage: err "Unable to do_something"
# Stderr helper function.
err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
  #exit 1
}

ff() {
  find . -type f -iname "*""$*""*"
}

fx() {
  find . -type f -iname "*""${1:-}""*" -exec "${2:-file}" {} \;
}

fwc() {
  find . -name "*.$1" -print0 | xargs -0 wc -l
}

extract() {
  if [[ -f "$1" ]]; then
    case "$1" in
      *.tar.bz2)   tar xvjf "$1"     ;;
      *.tar.gz)    tar xvzf "$1"     ;;
      *.bz2)       bunzip2 "$1"      ;;
      *.rar)       unrar x "$1"      ;;
      *.gz)        gunzip "$1"       ;;
      *.tar)       tar xvf "$1"      ;;
      *.tbz2)      tar xvjf "$1"     ;;
      *.tgz)       tar xvzf "$1"     ;;
      *.zip)       unzip "$1"        ;;
      *.Z)         uncompress "$1"   ;;
      *.7z)        7z x "$1"         ;;
      *)           echo "$1 cannot be extracted via >extract<" ;;
    esac
  else
    echo "$1 is not a valid file!"
  fi
}

emacs_server_ok() {
  emacsclient -a "false" -e "(boundp 'server-process)"
}

e() {
  if [[ "${1}" == '' ]]; then
    emacsclient --tty  .
  else
    emacsclient --tty "${1}"
  fi
} # Open, in current shell, using the emacs daemon.

et() {
  if [[ "${1}" == '' ]]; then
    emacs --no-window-system --quick .
  else
    emacs --no-window-system --quick "${1}"
  fi
} # Open quickly, in the current shell, using no config or daemon.

ec() {
  if [[ "${1}" == '' ]]; then
    emacsclient --no-wait .
  else
    emacsclient --no-wait "${1}"
  fi
} # Open, in the current frame, using the emacs daemon.

en() {
  if [[ "${1}" == '' ]]; then
    emacsclient --no-wait --create-frame .
  else
    emacsclient --no-wait --create-frame "${1}"
  fi
} # Open, in a new frame, using the emacs daemon.

ek() {
  if [[ "t" == "$(emacs_server_ok)" ]]; then
    echo "Shutting down the emacs server"
    emacsclient -e '(kill-emacs)'
  else
    echo "Emacs server not running"
  fi
} # Shutdown the running emacs daemon if the server-process is bound
  # and the server is in a good state.

ers() {
  if [[ "t" == "$(emacs_server_ok)" ]]; then
    echo "Shutting down the emacs server..."
    emacsclient -e '(kill-emacs)'
    echo "Restarting the emacs server..."
    emacs -u "$USER" --daemon --eval '(server-start)'
    emacsclient --no-wait --create-frame
  else
    echo "Emacs server not running, cannot restart. Invoke: 'esd'"
  fi
} # Safely shutdown and restart the emacs daemon.

sreboot() {
  if [[ "t" == "$(server_ok)" ]]; then
    echo "Shutting down the emacs server..."
    emacsclient -e '(client-save-kill-emacs)'
  fi
  echo "Shutting down MPD..."
  mpd --kill
  sudo shutdown -r now
}

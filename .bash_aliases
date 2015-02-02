# -*- mode: sh; -*-

sreboot() {
  if [[ "t" == "$(server_ok)" ]]; then
    echo "Shutting down the emacs server..."
    emacsclient -e '(client-save-kill-emacs)'
  fi
  echo "Shutting down MPD..."
  mpd --kill
  sudo shutdown -r now
}

ff() { find . -type f -iname "*""$*""*" ; }

fx() { find . -type f -iname "*""${1:-}""*" -exec "${2:-file}" {} \;  ; }

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

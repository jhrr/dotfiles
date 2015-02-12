#!/bin/sh

# TODO: Xresources -- http://git.sysphere.org/dotfiles/tree/xinitrc

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

export errorlog="$HOME/.xerrors"
export emacsserver="/tmp/emacs${UID}/server"

if (cp /dev/null "${errorlog}"); then
  chmod 600 "${errorlog}"
  exec >"${errorlog}" 2>&1
fi

xinput set-prop 11 'Device Enabled' 0  # Disable crap touchpad on x230
xsetroot -cursor_name left_ptr  # Pointer apperance
xset m 30/10 4  # Pointer control, acceleration and threshold
unclutter -grab &  # Hide cursor when not in use
setxkbmap -option ctrl:swapcaps  # Remap capslock and ctrl keys

# TODO: config monitors function...
# EXT="$(xrandr | grep ' connected' | grep -v LVDS1 | cut -f1 -d' ')"
# RES="$(xrandr | grep -A1 """$EXT connected""" | tail -1 | cut -f4 -d' ')"
# [ $EXT ] &&
#   xrandr --output LVDS1 \
#          --mode 1366x768 \
#          --primary \
#          --output $EXT \
#          --mode $RES \
#          --left-of LVDS1;
#
[ $EXT ] &&
  xrandr --output VGA1 \
         --auto \
         --output LVDS1 \
         --auto \
         --right-of VGA;

pkill dunst; dunst -config ~/.dunstrc &
trayer --edge top --align right --SetDockType true \
       --SetPartialStrut true --expand true --width 5 \
       --height 12 --transparent true --alpha 0 \
       --tint 0x000000 &
urxvtd --quiet --opendisplay --fork
dropboxd &
$HOME/bin/esd &
/usr/bin/mpd $HOME/.mpd/mpd.conf
pidof mpdscribble >& /dev/null
[ "$?" -ne 0 ] &&
  mpdscribble --conf ~/.mpdscribble/mpdscribble.conf &

cd $HOME  # make X always open new terms in ~/
xmonad
urxvtc

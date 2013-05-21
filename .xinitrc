#!/bin/sh
#
# X init
# ~/.xinitrc
# Name: nil
#

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Startup Scripts {{{
# -----------------------------------------------------------------------------

bash ~/.config/nil/hdmi-init &
nitrogen --restore &
xbacklight -set 100 &
synclient touchpadoff=0 &
syndaemon -k -i 1 -d &
xmodmap ~/.Xmodmap &
xcape -e 'Control_L=Escape' &
xcape -e 'Alt_R=emdash' &
xrdb -merge ~/.Xresources &
#redshift -l 37.9:-122.3 -t 6500:3700 &

# Sticky Keys.
#latchwork doesn't seem to work, fails quite often.
# I could probably get it to work, though I don't really want it anymore to begin with.
#xkbset exp =sticky =twokey =latchlock &
#xkbset sticky twokey latchlock &

# }}}

# Change DE/WM's by the command 'xinit asdf', where you have "asdf) exec the_asdf_start_cmd".
# 'xinit' by itself will launch the default session.
case $1 in
*)
	exec i3
	;;
esac

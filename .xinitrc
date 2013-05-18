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

exec bash ~/.config/nil/hdmi-init
exec nitrogen --restore
exec xbacklight -set 100
exec synclient touchpadoff=0
exec syndaemon -k -i 1 -d
exec xmodmap ~/.Xmodmap
exec xrdb -merge ~/.Xresources
exec xcape -e 'Control_L=Escape;Alt_R=emdash'

# Sticky Keys.
#latchwork doesn't seem to work, fails to work quite often.
#xkbset exp =sticky =twokey =latchlock
#xkbset sticky twokey latchlock

# }}}

# Change DE/WM's by the command 'xinit asdf', where you have "asdf) exec the_asdf_start_cmd".
# 'xinit' by itself will launch the default session.
case $1 in
*)
	exec i3
	;;
esac

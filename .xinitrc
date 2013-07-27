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

# Startup Scripts
autocutsel -fork &
autocutsel -selection PRIMARY -fork &
bash ~/.config/nil/hdmi-init &
mpd ~/.config/mpd/mpd.conf &
#mpdas &
nitrogen --restore &
synclient touchpadoff=0 &
syndaemon -k -i 1 -d &
#transmission-daemon &
xbacklight -set 100 &
xmodmap -e 'remove Lock = Caps_Lock'
xmodmap -e 'keysym Caps_Lock = Control_L'
xmodmap -e 'add Control = Control_L'
xcape -e 'Control_L=Escape'
xmodmap -e 'keycode 135 = Super_R'
#
#xmodmap -e 'keycode 108 = Alt_R'
#xmodmap -e 'add Alt = Alt_R'
#xcape -e 'Alt_R=emdash'
#
xrdb -merge ~/.Xresources
#redshift -l 37.9:-122.3 -t 6500:3700 &

# Change DE/WM's by the command 'xinit asdf', where you have "asdf) exec the_asdf_start_cmd".
# 'xinit' by itself will launch the default session.
case $1 in
*)
	exec i3
	;;
esac
xmodmap -e 'add Alt = Alt_R'

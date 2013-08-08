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

###############################################################################
# Audio and video output
###############################################################################

xrandr | grep "HDMI1 connected"
if [ $? -eq 0 ]; then
  #Do stuff if HDMI1 is connected.
    xrandr --output LVDS1 --auto --primary --output HDMI1 --auto --mode 1920x1080 --left-of LVDS1
    # Turned this off because I'd rather audo-toggle it manually, where it defaults to USB DAC audio.
    #ln -sf "/home/nil/.config/nil/asound.hdmi-connected" /home/nil/.asoundrc
else
    xrandr --output HDMI1 --off
    ln -sf "/home/nil/.config/nil/asound.hdmi-disconnected" /home/nil/.asoundrc
fi

###############################################################################
# Startup Scripts
###############################################################################

autocutsel -fork &
autocutsel -selection PRIMARY -fork &
compton -b
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

###############################################################################
# Desktop Environment/Window Manager
###############################################################################
# Change DE/WM's by the command 'xinit asdf', where you have "asdf) exec the_asdf_start_cmd".
# 'xinit' by itself will launch the default session. You can also manually start the application with just the exec command.

case $1 in
    #awesome) exec awesome ;;
    *) exec i3 ;;
    #*) exec awesome ;;
esac

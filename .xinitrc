#!/bin/sh
#
# ~/.xinitrc
# Author: Dustin Tran <dustinvtran.com>
#

###############################################################################
# Initial System Settings
###############################################################################

# HDMI
#~/bin/udev-hdmi
# Power Supply
#~/bin/udev-power-supply

###############################################################################
# Commands & Daemons
###############################################################################

#clipit &
autocutsel -fork &
autocutsel -selection PRIMARY -fork &
blockify &
compton -b
dropboxd &
mpd ~/.config/mpd/mpd.conf
rssdler -c ~/.config/rssdler/config.txt -d
syndaemon -k -i 0.5 -d
transmission-daemon &
xbacklight -set 50

setxkbmap -variant colemak
# Keybind CapsLock as Control_L
xmodmap -e 'remove Lock = Caps_Lock'
xmodmap -e 'keycode 66 = Control_L'
xmodmap -e 'add Control = Control_L'
# Keybind Menu key as Super_R
xmodmap -e 'keycode 135 = Super_R'
# Keybind Alt_R key as Alt_R and emdash
xmodmap -e 'keycode 255 = emdash'
xmodmap -e 'keycode 108 = Alt_R'
# Keybind Ctrl-V to Shift+Insert.
#xmodmap -e 'keycode 55 = v V Insert'
#xbindkeys
# temp: Keybind Shift+Super_L to do Shift+Insert
xmodmap -e 'keycode 133 = Super_L Insert'
# Double load CapsLock (Control_L) as Escape, Alt_R as emdash
xcape -e 'Control_L=Escape;Alt_R=emdash'

xrdb -merge ~/.Xresources
mpdas &

###############################################################################
# Desktop Environment/Window Manager
###############################################################################

exec awesome &

###############################################################################
# Applications
###############################################################################

PID=$!
gvim &
urxvt -name dvt -g 102x21 &
urxvt -name ranger -g 102x21 -e ranger &
urxvt -name tcli -g 129x18 -e transmission-remote-cli &
sleep 10
firefox &
urxvt -name irssi -g 102x24 -e irssi &
echo 'awesome.restart()' | awesome-client &
wait $PID

#exec qtile

#xsetroot -cursor_name left_ptr
#sxhkd &
#feh --bg-scale ~/.config/bspwm/wallpaper.jpg
##/home/dvt/.config/bspwm/panel/panel dzen2 &
#exec bspwm
##exec wm
##exec /home/dvt/bin/wm

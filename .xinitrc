#!/bin/sh
#
# X init
# ~/.xinitrc
# Name: Dustin Tran
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
#blockify &
compton -b
dropboxd &
mpd ~/.config/mpd/mpd.conf
rssdler -c ~/.config/rssdler/config.txt -d
syndaemon -k -i 0.5 -d
transmission-daemon &
xbacklight -set 50
setxkbmap -variant colemak
#setxkbmap -layout us
xmodmap -e 'remove Lock = Caps_Lock'
xmodmap -e 'keycode 66 = Control_L'
xmodmap -e 'add Control = Control_L'
xmodmap -e 'keycode 135 = Super_R'
xmodmap -e 'keycode 255 = emdash'
xmodmap -e 'keycode 108 = Alt_R'
xcape -e 'Control_L=Escape;Alt_R=emdash'
xrdb -merge ~/.Xresources
mpdas &

###############################################################################
# Applications
###############################################################################

firefox &
gvim &

# [L+E] Use this if you have both laptop and external display
#urxvt -name nil -font 'xft:uushi' -boldFont 'xft:uushi' -g 85x24 &
#urxvt -name irssi -font 'xft:uushi' -boldFont 'xft:uushi' -g 85x31 -e irssi &
#urxvt -name ncmpcpp -font 'xft:uushi' -boldFont 'xft:uushi' -g 85x9 -e ncmpcpp &
#urxvt -name ranger -font 'xft:uushi' -boldFont 'xft:uushi' -g 85x19 -e ranger &

# [L] Use this if you only have laptop display
urxvt -name nil -g 85x24 &
urxvt -name irssi -g 102x35 -e irssi &
urxvt -name ncmpcpp -g 102x10 -e ncmpcpp &
urxvt -name ranger -g 102x21 -e ranger &

urxvt -name tcli -g 129x18 -e nil-transmission-remote-cli &

###############################################################################
# Desktop Environment/Window Manager
###############################################################################

exec awesome
#PID=$!
#sleep 5 && echo 'awesome.restart()' | awesome-client &
#wait $PID

#exec qtile

#xsetroot -cursor_name left_ptr
#sxhkd &
#feh --bg-scale ~/.config/bspwm/wallpaper.jpg
##/home/nil/.config/bspwm/panel/panel dzen2 &
#exec bspwm
##exec wm
##exec /home/nil/bin/wm

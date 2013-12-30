#!/bin/sh
#
# X init
# ~/.xinitrc
# Name: nil
#

###############################################################################
# Initial System Settings
###############################################################################

# HDMI
~/bin/udev-hdmi
# Power Supply
~/bin/udev-power-supply

###############################################################################
# Commands & Daemons
###############################################################################

autocutsel -fork
autocutsel -selection PRIMARY -fork
compton -b
dropboxd &
mpd ~/.config/mpd/mpd.conf
rssdler -c ~/.config/rssdler/config.txt -d
synclient touchpadoff=0
syndaemon -k -i 1 -d
transmission-daemon &
xbacklight -set 100
setxkbmap -variant colemak
xmodmap -e 'remove Lock = Caps_Lock'
xmodmap -e 'keycode 66 = Control_L'
xmodmap -e 'add Control = Control_L'
xmodmap -e 'keycode 135 = Super_R'
xmodmap -e 'keycode 255 = emdash'
xcape -e 'Control_L=Escape;Alt_R=emdash'
xrdb -merge ~/.Xresources
mpdas &

###############################################################################
# Applications
###############################################################################

firefox &
gvim &
libreoffice ~/Dropbox/nil/Aesthetics/Macros.ods &

# [L+E] Use this if you have both laptop and external display.
#urxvt -name nil -font 'xft:uushi' -boldFont 'xft:uushi' -g 85x24 &
#urxvt -name irssi -font 'xft:uushi' -boldFont 'xft:uushi' -g 85x31 -e irssi &
#urxvt -name ncmpcpp -font 'xft:uushi' -boldFont 'xft:uushi' -g 85x9 -e ncmpcpp &
#urxvt -name ranger -font 'xft:uushi' -boldFont 'xft:uushi' -g 85x19 -e ranger &

# [L] Use this if you only have laptop display.
#urxvt -name nil -g 85x24 &
#urxvt -name irssi -g 102x35 -e irssi &
#urxvt -name ncmpcpp -g 102x10 -e ncmpcpp &
#urxvt -name ranger -g 102x21 -e ranger &
# temp setting for vacation
urxvt -name nil -g 80x24 &
urxvt -name irssi -g 80x35 -e irssi &
urxvt -name ncmpcpp -g 80x10 -e ncmpcpp &
urxvt -name ranger -g 80x21 -e ranger &

urxvt -name tcli -g 129x18 -e nil-transmission-remote-cli &

###############################################################################
# Desktop Environment/Window Manager
###############################################################################

case $1 in
    *) exec awesome ;;
esac

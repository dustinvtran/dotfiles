#! /bin/bash

# This displays mpd now playing info if mpd is running.

so=$(mpc current -f %title%)
art=$(mpc current -f %artist%)

if [ "`mpc | grep "^\[paused\]"`" != "" ]; then
    echo -n "  ⮕ | Paused: | $so | by | $art"
    elif [ "`mpc | grep "^\[playing\]"`" != "" ]; then
    echo -n "  ⮕ | Playing: | $so | by | $art"
    else
    echo -n "  ⮕ [ | mpd stopped | ]"
fi

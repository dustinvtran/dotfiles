#!/usr/bin/env python
"""Print to stdout the now playing information from spotify."""

from gi.repository import Playerctl

player = Playerctl.Player()
status = player.get_property('status')

if status == "Playing":
    title = player.get_title()
    artist = player.get_artist()
    print(" ⮕ | Playing: | %s | by | %s " %(title, artist))
elif status == "Paused":
    title = player.get_title()
    artist = player.get_artist()
    print(" ⮕ | Paused: | %s | by | %s " %(title, artist))
else:
    print("")

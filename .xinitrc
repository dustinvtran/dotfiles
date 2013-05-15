#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Change DE/WM's by the command 'xinit asdf', where you have "asdf) exec the_asdf_start_cmd".
# 'xinit' by itself will launch the default session.
case $1 in
*)
	exec i3
	;;
esac

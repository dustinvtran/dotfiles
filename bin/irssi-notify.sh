#! /bin/bash

# As my irssi notification system, this echoes the latest highlighter's nick. I then set
# a keybind in my window manager which clears the notification, only to reappear (with the next
# highlighter's nick) via this script.
# This is done by awk-ing whenever there's a non-empty last line in the fnotify file
# (the fnotify file in turn is triggered by highlights and private messages).

line=$(tail -n 1 /home/nil/.irssi/logs/fnotify)
secondword=$(tail -n 1 /home/nil/.irssi/logs/fnotify | awk -F " " '{print $2}')

if [ -n "${line}" ]; then
    if [[ $line != \#* ]]; then
        nick=$(tail -n 1 /home/nil/.irssi/logs/fnotify | awk -F " " '{print $1}')
    elif [[ $secondword = [a-zA-Z0-9]* ]];then
        nick=$(tail -n 1 /home/nil/.irssi/logs/fnotify | awk -F " " '{print $2}')
    else
        nick=$(tail -n 1 /home/nil/.irssi/logs/fnotify | awk -F " " '{print $3}')
    fi
    echo "  ⮜ $nick"
fi

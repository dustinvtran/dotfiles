#! /bin/bash

# As my mail notification system, this displays two unread mail counts if either is greater than zero. The unread mail
# counts are outputted by two gmail scripts, each of which monitor a
# different account.

# Some bugs:
# I get this output each time it runs.
#Exception BrokenPipeError: BrokenPipeError(32, 'Broken pipe') in <_io.TextIOWrapper name='<stdout>' mode='w' encoding='UTF-8'> ignored
# Also, the big problem is the blinking, and that it stays on Loading... for so long. Can't it just keep the output?

#echo "Loading... "
#gmail1=$(python gmail1.py)
#gmail2=$(python gmail2.py)
#icon='/home/nil/.config/nil/conky/mail.xbm'

#if [ $gmail1 -gt 0 ] || [ $gmail2 -gt 0 ]; then
    #echo "  ^i($icon) $gmail1$gmail2"
#fi

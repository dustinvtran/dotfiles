#
# ~/.zprofile
# Author: Dustin Tran <dustinvtran.com>
#

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

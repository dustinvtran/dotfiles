#
# ~/.zshenv
# Author: Dustin Tran <dustinvtran.com>
#

export EDITOR=gvim
export PATH=~/bin:~/bin/notme:$PATH
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 fdm=indent nomod noma nolist nonu nornu' -c 'nnoremap q :q<CR>' -\""
export PYTHONSTARTUP=~/.pythonrc

# bspwm
export PANEL_FIFO=/tmp/panel-fifo
export PANEL_HEIGHT=24
export PATH=$PATH:~/.config/bspwm/panel:~/.config/bspwm/bin

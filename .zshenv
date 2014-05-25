#
# ~/.zshenv
# Name: nil
#

export EDITOR=gvim
export PATH=~/bin:~/bin/notme:$PATH
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 fdm=indent nomod noma nolist nonu nornu' -c 'nnoremap q :q<CR>' -\""
export PYTHONSTARTUP=~/.pythonrc

#bspwm
export PANEL_FIFO=/tmp/panel-fifo
export PANEL_HEIGHT=24

export BSPWM_TREE=/tmp/bspwm.tree
export BSPWM_HISTORY=/tmp/bspwm.history
export BSPWM_STACK=/tmp/bspwm.stack

#
# ~/.zprofile
# Name: nil
#

. $HOME/.zshrc

if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then
    xinit -- :0
    logout
fi

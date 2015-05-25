#
# ~/.zshenv
# Author: Dustin Tran <dustinvtran.com>
#

#export EDITOR=vim
export EDITOR=gvim
export PYTHONSTARTUP=~/.pythonrc

export PATH=/usr/local/bin:$(brew --prefix coreutils)/libexec/gnubin:$PATH
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH=/usr/texbin:$PATH # does this work for xelatex?
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

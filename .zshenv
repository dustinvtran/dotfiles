#
# ~/.zshenv
# Author: Dustin Tran <dustinvtran.com>
#

export EDITOR=gvim

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_74.jdk/Contents/Home/

export PATH=/usr/local/bin:$(brew --prefix coreutils)/libexec/gnubin:$PATH
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH=$PATH:$HOME/bin
export PATH=/usr/texbin:$PATH # does this work for xelatex?
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# python
export WORKON_HOME=~/Envs
source /usr/local/bin/virtualenvwrapper.sh
export PYTHONSTARTUP=~/.pythonrc

# hotfix, for using numpy in cython
export CFLAGS="-I /usr/local/lib/python2.7/site-packages/numpy/core/include $CFLAGS"

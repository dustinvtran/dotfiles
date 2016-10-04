#
# ~/.zshenv
# Author: Dustin Tran <dustinvtran.com>
#

export EDITOR=gvim

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_74.jdk/Contents/Home/

export PATH=$PATH:/usr/local/bin
export PATH="$PATH:$(brew --prefix)/bin"
# See ~/.zshrc for path.

# caskroom
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export VIM_APP_DIR=/usr/local/Caskroom/macvim/7.4-73/MacVim-snapshot-73

# python
export WORKON_HOME=~/Envs
source /usr/local/bin/virtualenvwrapper.sh
export PYTHONSTARTUP=~/.pythonrc

# hotfix, for using numpy in cython
export CFLAGS="-I /usr/local/lib/python2.7/site-packages/numpy/core/include $CFLAGS"

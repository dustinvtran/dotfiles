#
# zsh environment variables
# ~/.zshenv
# Name: nil
#

export EDITOR=gvim
export PATH=~/bin:$PATH

# Open all man pages in Vim, under uneditable settings.
# Adding 'q' as the universal CLI shortcut for exit.
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 fdm=indent nomod noma nolist nonu nornu' -c 'nnoremap q :q<CR>' -\""

# Make Bundler (for Ruby) install locally.
export GEM_HOME=~/.gem/ruby/2.0.0

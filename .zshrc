#
# ~/.zshrc
# Author: Dustin Tran <dustintran.com>
#

# General Settings
# -----------------------------------------------------------------------------

setopt auto_name_dirs
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
setopt multios
setopt cdablevarS
setopt autocd
setopt extendedglob
setopt interactivecomments
setopt nobeep
setopt nocheckjobs
setopt correct

CACHEDIR="$HOME/.cache/zsh-cache"

################################################################################
# History
################################################################################

HISTSIZE=1000
SAVEHIST=${HISTSIZE}
HISTFILE=~/.zshinfo
setopt histignoredups
setopt share_history
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history

# Completion
# -----------------------------------------------------------------------------

# Use (advanced) completion functionality
# TODO
#autoload -U compinit
#compinit -d $CACHEDIR/zcompdump 2>/dev/null

# Use cache to speed completion up and set cache folder path
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $CACHEDIR

# Auto-insert first suggestion
setopt menu_complete

# If the <tab> key is pressed with multiple possible options, print the
# options. If the options are printed, begin cycling through them
zstyle ':completion:*' menu select

# Set format for warnings
zstyle ':completion:*:warnings' format 'Sorry, no matches for: %d%b'

# Use colors when outputting file names for completion options
zstyle ':completion:*' list-colors ''

# Do not prompt to cd into current directory
# For example, cd ../<tab> should not prompt current directory
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# Completion for kill
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,cputime,cmd'

# Show completion for hidden files also
zstyle ':completion:*' file-patterns '*(D)'

# Red dots!
expand-or-complete-with-dots() {
  echo -n "\e[31m......\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

# Prompt Style
# -----------------------------------------------------------------------------

autoload -U colors && colors

PS1=$'%(!.%S-ROOT-%s.%n) %~ '
#zle-keymap-select () {
#  if [ $KEYMAP = vicmd ]; then
#    PS1=$'%{\e[0m%}%{\e[48;5;240m%}%{\e[38;5;235m%} %(!.%S-ROOT-%s.%n) \e[38;5;240m%}\e[48;5;249m%}⮀%{\e[38;5;235m%}%{\e[48;5;249m%} %~ %{\e[48;5;0m%}%{\e[38;5;249m%}⮀ %{\e[0m%}'
#    () { return $__prompt_status }
#    zle reset-prompt
#  else
#    PS1=$'%{\e[0m%}%{\e[48;5;255m%}%{\e[38;5;235m%} %(!.%S-ROOT-%s.%n) \e[38;5;255m%}\e[48;5;249m%}⮀%{\e[38;5;235m%}%{\e[48;5;249m%} %~ %{\e[48;5;0m%}%{\e[38;5;249m%}⮀ %{\e[0m%}'
#    () { return $__prompt_status }
#    zle reset-prompt
#  fi
#}
#zle -N zle-keymap-select

#zle-line-init () {
#  zle -K viins
#  PS1=$'%{\e[0m%}%{\e[48;5;255m%}%{\e[38;5;235m%} %(!.%S-ROOT-%s.%n) \e[38;5;255m%}\e[48;5;249m%}⮀%{\e[38;5;235m%}%{\e[48;5;249m%} %~ %{\e[48;5;0m%}%{\e[38;5;249m%}⮀ %{\e[0m%}'
#  () { return $__prompt_status }
#  zle reset-prompt
#}
#zle -N zle-line-init

# zle widgets
# -----------------------------------------------------------------------------

# Delete all characters between a pair of characters. Mimics Vim's "di" text
# object functionality
# TODO: get this working..
delete-in() {
  # Create locally-scoped variables we'll need
  local CHAR LCHAR RCHAR LSEARCH RSEARCH COUNT
  # Read the character to indicate which text object we're deleting
  read -k CHAR
  if [ "$CHAR" = "w" ]
    then # diw, delete the word
    # find the beginning of the word under the cursor
    zle vi-backward-word
    # set the left side of the delete region at this point
    LSEARCH=$CURSOR
    # find the end of the word under the cursor
    zle vi-forward-word
    # set the right side of the delete region at this point
    RSEARCH=$CURSOR
    # Set the BUFFER to everything except the word we are removing
    RBUFFER="$BUFFER[$RSEARCH+1,${#BUFFER}]"
    LBUFFER="$LBUFFER[1,$LSEARCH]"
    return
  # diw was unique. For everything else, we just have to define the
  # characters to the left and right of the cursor to be removed
  elif [ "$CHAR" = "(" ] || [ "$CHAR" = ")" ] || [ "$CHAR" = "b" ]
  then # di), delete inside of a pair of parenthesis
    LCHAR="("
    RCHAR=")"
  elif [ "$CHAR" = "[" ] || [ "$CHAR" = "]" ]
  then # di], delete inside of a pair of square brackets
    LCHAR="["
    RCHAR="]"
  elif [ $CHAR = "{" ] || [ $CHAR = "}" ] || [ "$CHAR" = "B" ]
  then # di], delete inside of a pair of braces
    LCHAR="{"
    RCHAR="}"
  else
    # The character entered does not have a special definition
    # Simply find the first instance to the left and right of the
    # cursor
    LCHAR="$CHAR"
    RCHAR="$CHAR"
  fi
  # Find the first instance of LCHAR to the left of the cursor and the
  # first instance of RCHAR to the right of the cursor, and remove
  # everything in between
  # Begin the search for the left-sided character directly the left of the cursor
  LSEARCH=${#LBUFFER}
  # Keep going left until we find the character or hit the beginning of the buffer
  while [ "$LSEARCH" -gt 0 ] && [ "$LBUFFER[$LSEARCH]" != "$LCHAR" ]
  do
    LSEARCH=$(expr $LSEARCH - 1)
  done
  # If we hit the beginning of the command line without finding the character, abort
  if [ "$LBUFFER[$LSEARCH]" != "$LCHAR" ]
  then
    return
  fi
  # start the search directly to the right of the cursor
  RSEARCH=0
  # Keep going right until we find the character or hit the end of the buffer
  while [ "$RSEARCH" -lt $(expr ${#RBUFFER} + 1 ) ] && [ "$RBUFFER[$RSEARCH]" != "$RCHAR" ]
  do
    RSEARCH=$(expr $RSEARCH + 1)
  done
  # If we hit the end of the command line without finding the character, abort
  if [ "$RBUFFER[$RSEARCH]" != "$RCHAR" ]
  then
    return
fi
# Set the BUFFER to everything except the text we are removing
  RBUFFER="$RBUFFER[$RSEARCH,${#RBUFFER}]"
  LBUFFER="$LBUFFER[1,$LSEARCH]"
}
zle -N delete-in


# Delete all characters between a pair of characters and then go to insert mode
# Mimics Vim's "ci" text object functionality
change-in() {
  zle delete-in
  zle vi-insert
}
zle -N change-in

# Delete all characters between a pair of characters as well as the surrounding
# characters themselves. Mimics Vim's "da" text object functionality
delete-around() {
  zle delete-in
  zle vi-backward-char
  zle vi-delete-char
  zle vi-delete-char
}
zle -N delete-around

# Delete all characters between a pair of characters as well as the surrounding
# characters themselves and then go into insert mode Mimics Vim's "ca" text
# object functionality
change-around() {
  zle delete-in
  zle vi-backward-char
  zle vi-delete-char
  zle vi-delete-char
  zle vi-insert
}
zle -N change-around

# Zsh's vi-up/down-line-or-history does what I want but leaves the cursor at the
# beginning rather than front. Perplexing!
vim-up-line-or-history() {
  zle vi-up-line-or-history
  zle vi-end-of-line
}
zle -N vim-up-line-or-history
vim-down-line-or-history() {
  zle vi-down-line-or-history
  zle vi-end-of-line
}
zle -N vim-down-line-or-history

zle -N yank-x-selection
autoload edit-command-line
zle -N edit-command-line

# The Vim setup
# -----------------------------------------------------------------------------

bindkey -v

# Disable flow control. Specifically, ensure that ctrl-s does not stop
# terminal flow so that it can be used in other programs (such as Vim)
setopt noflowcontrol
stty -ixon

# Disable use of ^D
stty eof undef

# 1 sec <Esc> time delay? zsh pls
# Set to 10ms for key sequences. (Note "bindkey -rp '^['" removes the
# availability of any '^[...' mappings, so use this instead.)
KEYTIMEOUT=1

################################################################################
# Insert mode
################################################################################

# Vim defaults
bindkey -M viins "^?" backward-delete-char    # i_Backspace
bindkey -M viins '^[[3~' delete-char      # i_Delete
bindkey -M viins '^[[Z' reverse-menu-complete # i_SHIFT-Tab

# Non-Vim default mappings I use everywhere
bindkey -M viins "^N" vim-down-line-or-history  # i_CTRL-N
bindkey -M viins "^E" vim-up-line-or-history  # i_CTRL-E

# Edit current line in veritable Vim
bindkey -M viins "^H" edit-command-line     # i_CTRL-I

################################################################################
# Normal mode
################################################################################

# Vim defaults
#bindkey -M vicmd "ca" change-around       # ca
#bindkey -M vicmd "ci" change-in         # ci
bindkey -M vicmd "cc" vi-change-whole-line    # cc
#bindkey -M vicmd "da" delete-around       # da
#bindkey -M vicmd "di" delete-in         # di
bindkey -M vicmd "dd" kill-whole-line     # dd
bindkey -M vicmd "^R" redo            # CTRL-R

# Non-Vim default mappings I use everywhere
bindkey -M vicmd "s" backward-char        # i_s
bindkey -M vicmd "t" forward-char       # i_t
bindkey -M vicmd "z" vi-substitute        # z

# Alias & Functions
# -----------------------------------------------------------------------------

################################################################################
# Alias
################################################################################

# Default flags
#alias crontab="EDITOR=vim crontab"
alias df="df -h"
alias du="du -h -c"
alias grep="grep --color"
alias ls="gls -a --color"
alias coursera-dl="coursera-dl -n -f 'mp4'"
alias youtube-dl="youtube-dl -cik"
alias ranger='ranger --choosedir=/tmp/rangerdir; LASTDIR=`cat /tmp/rangerdir`; cd "$LASTDIR"; unset LASTDIR'

# Default flags for programming languages
alias matlab="matlab -nodesktop"
alias R="R --no-save"

alias mount2-ntfs="sudo ntfs-3g -o uid=501,gid=20 /dev/disk2s1 /mnt/disk2s1"
alias mount3-ntfs="sudo ntfs-3g -o uid=501,gid=20 /dev/disk3s1 /mnt/disk3s1"
alias mount2-ext="sudo mount -t fuse-ext2 /dev/disk2s1 /mnt/disk2s1"
alias mount3-ext="sudo mount -t fuse-ext2 /dev/disk3s1 /mnt/disk3s1"
#sudo ext4fuse /dev/disk2s1 /mnt/disk2s1 -o allow_other
#sudo umount /mnt/disk2s1
alias umount2="sudo umount /mnt/disk2s1"
alias umount3="sudo umount /mnt/disk3s1"

# Make backup files ~/doc/package-list, ~/system/groups, ~/system/systemctl
# TODO: write equivalent for os x as external shell script
alias backup="(groups > ~/system/groups) && (systemctl --all > ~/system/systemctl) &&\
(echo 'This lists any installed packages that are not in the base or base-devel group, and hence are likely \
installed manually by\n me. See ~/.zshrc for the command.\n' > ~/doc/package-list\
&& (comm -23 <(pacman -Qeq|sort) <(pacman -Qgq base base-devel|sort)\
&& echo 'matlab r-2012b (\"make install\")') | sort >> ~/doc/package-list)"

# List directory structure of ~/dvt/media
# TODO: write as external shell script
alias media-catalog=" ( find '/mnt/sdb1' -type d -not -path '*/\[backlog\]/*'\
    | sed -e 's/^\/mnt\/sdb1\///' -e '/^\/media\/sdb1/d'\
    | sed -e 's/\[backlog\]/\[aabacklog\]/'\
    && echo 'anime/[aabacklog]/...
anime/[aabacklog]/[completed]
anime/[aabacklog]/[completed]/...
anime/[aabacklog]/[current]
anime/[aabacklog]/[current]/...
anime/[aabacklog]/[winter-2014]
anime/[aabacklog]/[winter-2014]/...
films/[aabacklog]/...
films/[aabacklog]/[completed]
films/[aabacklog]/[completed]/...
literature/[aabacklog]/...
literature/[aabacklog]/[completed]
literature/[aabacklog]/[completed]/...
manga/[aabacklog]/...
manga/[aabacklog]/[completed]
manga/[aabacklog]/[completed]/...
manga/[aabacklog]/[current]
manga/[aabacklog]/[current]/...
music/[aabacklog]/...
music/[aabacklog]/[completed]
music/[aabacklog]/[completed]/...
tv/[aabacklog]/...
tv/[aabacklog]/[completed]
tv/[aabacklog]/[completed]/...
video games/[aabacklog]/...
video games/[aabacklog]/[completed]
video games/[aabacklog]/[completed]/...
visual novels/[aabacklog]/...
visual novels/[aabacklog]/[completed]
visual novels/[aabacklog]/[completed]/...' )\
    | sort\
    | sed -e 's/\[aabacklog\]/\[backlog\]/'\
    | sed -e 's/^\(anime\|films\|literature\|manga\|music\|tv\|video games\|visual novels\)$/\n&/'\
    | sed -e '1i This lists the entire directory structure of my ~/dvt/media folder, which is a collection\
 of all titles I rate >=8/10 and\n their affiliated installments. It also stores my massive backlogs within each\
 medium, but I omit them here. Why archive\n my media directory structure, you ask? Because its so pretty and\
 autistic of me I simply must. When you\x27re a consumer,\n there ought to be a competent way to organize your\
 collection. See ~/.zshrc for the command.'\
    > ~/doc/media-catalog"

# CLI applications
#alias screencapture="screencapture -T 3 ~/dvt/media/pictures/screencaps/desktop/$(date +%Y-%m-%T).png"
#alias screencapturei="screencapture -i ~/dvt/media/pictures/screencaps/desktop/$(date +%Y-%m-%T).png"
#alias byzanz-record="cd ~/dvt/media/pictures/screencaps/byzanz && byzanz-record -c -d 10 dvt.gif && cd -"

################################################################################
# Functions
################################################################################

# The best zip! Don't include parent folders, don't nest zip function, zip
# recursively, and auto-take zip's second argument as first
zip() {
  name="$(basename -- "$1")"
  cd "$(dirname -- "$1")" &&
  command zip -r "$name.zip" "$name"
}

function python {
    if [[ ! -z "$VIRTUAL_ENV" ]]; then
        PYTHONHOME=$VIRTUAL_ENV /usr/local/bin/python "$@"
    else
        /usr/local/bin/python "$@"
    fi
}

function ipython {
    if [[ ! -z "$VIRTUAL_ENV" ]]; then
        PYTHONHOME=$VIRTUAL_ENV /usr/local/bin/ipython "$@"
    else
        /usr/local/bin/ipython "$@"
    fi
}

function python3 {
    if [[ ! -z "$VIRTUAL_ENV" ]]; then
        PYTHONHOME=$VIRTUAL_ENV /usr/local/bin/python3 "$@"
    else
        /usr/local/bin/python3 "$@"
    fi
}

# Due to Sierra, this has to be put in .zshrc instead of .zshenv.
# default to homebrew; also add ~/bin
export PATH=/usr/local/bin:$(brew --prefix coreutils)/libexec/gnubin:$PATH
export PATH=$PATH:$HOME/bin
export PATH=$PATH:/Library/TeX/texbin
source /usr/local/bin/virtualenvwrapper.sh

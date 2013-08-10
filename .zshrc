#
# zsh dotfile
# ~/.zshrc
# Name: nil
#
# To-Do List {{{
# -----------------------------------------------------------------------------

# High Priority:
#   * Deletearound not working.
#   * slow split second startup (urxvt issue?).
#   * Ctrl-I Doesn't work; also need a good keybind for it.
#   * tab completion doesn't work on some commands (e.g. fasd commands).
#   * tab completion menu colors for scp  are wonky/inverted.
# Medium Priority:
#   * Better ls and grep colors, and better ls style.
#   * have it autoopen files that arent commands in the respective application (e.g. gvim, mplayer, etc).
#   * display the red dots while waiting for long commands as well, e.g., cp large files, pl, etc.
#   * make zle widget for 's/S' as your insert char function
# Low Priority:
#   * Get working ip address function.
#   * Reopen last closed client/application/window function.
#       * E.g., it logs all the processes that disappear, and then it opens up the last line.
#       * Some smart WMs can already do this: gnome-shell already keeps track of what windows belong to
#           * which app (in the sense of /usr/share/applications)
#   * all keybind/vim stuff lost during ssh session, wonky prompt
#   * When pressing <CR> while still in cmd mode (green), the directory stays the cmd-color. I would like the color to reset back to the default (red) before <CR> is hit, so that it's /always/ the default (red) unless I'm in cmd mode (blue).

# }}}
# General Settings. {{{
# -----------------------------------------------------------------------------

# Some sane settings.
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

# Do not consider "/" a word character. One benefit of this is that when
# hitting ctrl-w in insert mode (which deletes the word before the cursor) just
# before a filesystem path, it only removes the last item of the path and not
# the entire thing.
WORDCHARS=${WORDCHARS//\/}

# Autocorrection. Note there is a correct_all but it's often too persistent.
setopt correct
# Autocorrection for git.
#git config --global help.autocorrect 1
# When offering typo corrections, do not propose anything which starts with an
# underscore (such as many of Zsh's shell functions).
CORRECT_IGNORE='_*'

# History.
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

fasd_cache="$HOME/.config/nil/cache/.fasd-init-cache"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init auto >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

# }}}
# Completion. {{{
# -----------------------------------------------------------------------------

# Zsh's completion can benefit from caching. Set the directory in which to
# load/store the caches.
CACHEDIR="/home/nil/.config/nil/cache/zsh-cache"

# Use (advanced) completion functionality.
autoload -U compinit
compinit -d $CACHEDIR/zcompdump 2>/dev/null

# Use cache to speed completion up and set cache folder path.
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $CACHEDIR

# Auto-insert first suggestion.
setopt menu_complete

# If the <tab> key is pressed with multiple possible options, print the
# options. If the options are printed, begin cycling through them.
zstyle ':completion:*' menu select

# Set format for warnings.
zstyle ':completion:*:warnings' format 'Sorry, no matches for: %d%b'

# Use colors when outputting file names for completion options.
zstyle ':completion:*' list-colors ''

# Do not prompt to cd into current directory.
# For example, cd ../<tab> should not prompt current directory.
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# Completion for kill.
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,cputime,cmd'

# Show completion for hidden files also.
zstyle ':completion:*' file-patterns '*(D)'

# Red dots!
expand-or-complete-with-dots() {
    echo -n "\e[31m......\e[0m"
    zle expand-or-complete
    zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

# }}}
# Appearance & Prompt Style. {{{
# -----------------------------------------------------------------------------

# Enable colors (necessary for prompt).
autoload -U colors && colors

# ls colors.
alias ls='ls -a --color'
alias lsa='ls -lah --color'

# grep colors.
alias grep='grep --color'

# Prompt Style.
# This changes PS1 dynamically depending on insert or command mode.
PS1="%{[38;05;8;48;05;4m%} %(!.%S-ROOT-%s.%n) %{[38;05;4;48;05;1m%}⮀%{[00m%}%{[38;05;8;48;05;1m%} %~ %{[00m%}%{[38;05;1m%}⮀ %{[00m%}"


zle-keymap-select () {
if [[ $TERM == "rxvt-unicode" || $TERM == "rxvt-unicode-256color" ]]; then
    if [ $KEYMAP = vicmd ]; then
        PS1="%{[38;05;8;48;05;2m%} %(!.%S-ROOT-%s.%n) %{[38;05;2;48;05;1m%}⮀%{[00m%}%{[38;05;8;48;05;1m%} %~ %{[00m%}%{[38;05;1m%}⮀ %{[00m%}"
        () { return $__prompt_status }
        zle reset-prompt
    else
        PS1="%{[38;05;8;48;05;4m%} %(!.%S-ROOT-%s.%n) %{[38;05;4;48;05;1m%}⮀%{[00m%}%{[38;05;8;48;05;1m%} %~ %{[00m%}%{[38;05;1m%}⮀ %{[00m%}"
        () { return $__prompt_status }
        zle reset-prompt
    fi
fi
}
zle -N zle-keymap-select

zle-line-init () {
    zle -K viins
    if [[ $TERM == "rxvt-unicode" || $TERM = "rxvt-unicode-256color" ]]; then
        PS1="%{[38;05;8;48;05;4m%} %(!.%S-ROOT-%s.%n) %{[38;05;4;48;05;1m%}⮀%{[00m%}%{[38;05;8;48;05;1m%} %~ %{[00m%}%{[38;05;1m%}⮀ %{[00m%}"
        () { return $__prompt_status }
        zle reset-prompt
    fi
}
zle -N zle-line-init

# }}}
# zle widgets. {{{
# -----------------------------------------------------------------------------
# The ZLE widges are all followed by "zle -<MODE> <NAME>" and bound below in the "Key Bindings" section.

# Delete all characters between a pair of characters. Mimics Vim's "di" text
# object functionality.
delete-in() {
    # Create locally-scoped variables we'll need
    local CHAR LCHAR RCHAR LSEARCH RSEARCH COUNT
    # Read the character to indicate which text object we're deleting.
    read -k CHAR
    if [ "$CHAR" = "w" ]
        then # diw, delete the word.
        # find the beginning of the word under the cursor
        zle vi-backward-word
        # set the left side of the delete region at this point
        LSEARCH=$CURSOR
        # find the end of the word under the cursor
        zle vi-forward-word
        # set the right side of the delete region at this point
        RSEARCH=$CURSOR
        # Set the BUFFER to everything except the word we are removing.
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
        # The character entered does not have a special definition.
        # Simply find the first instance to the left and right of the
        # cursor.
        LCHAR="$CHAR"
        RCHAR="$CHAR"
    fi
    # Find the first instance of LCHAR to the left of the cursor and the
    # first instance of RCHAR to the right of the cursor, and remove
    # everything in between.
    # Begin the search for the left-sided character directly the left of the cursor.
    LSEARCH=${#LBUFFER}
    # Keep going left until we find the character or hit the beginning of the buffer.
    while [ "$LSEARCH" -gt 0 ] && [ "$LBUFFER[$LSEARCH]" != "$LCHAR" ]
    do
        LSEARCH=$(expr $LSEARCH - 1)
    done
    # If we hit the beginning of the command line without finding the character, abort.
    if [ "$LBUFFER[$LSEARCH]" != "$LCHAR" ]
    then
        return
    fi
    # start the search directly to the right of the cursor
    RSEARCH=0
    # Keep going right until we find the character or hit the end of the buffer.
    while [ "$RSEARCH" -lt $(expr ${#RBUFFER} + 1 ) ] && [ "$RBUFFER[$RSEARCH]" != "$RCHAR" ]
    do
        RSEARCH=$(expr $RSEARCH + 1)
    done
    # If we hit the end of the command line without finding the character, abort.
    if [ "$RBUFFER[$RSEARCH]" != "$RCHAR" ]
    then
        return
fi
# Set the BUFFER to everything except the text we are removing.
    RBUFFER="$RBUFFER[$RSEARCH,${#RBUFFER}]"
    LBUFFER="$LBUFFER[1,$LSEARCH]"
}
zle -N delete-in


# Delete all characters between a pair of characters and then go to insert mode.
# Mimics Vim's "ci" text object functionality.
change-in() {
    zle delete-in
    zle vi-insert
}
zle -N change-in

# Delete all characters between a pair of characters as well as the surrounding
# characters themselves. Mimics Vim's "da" text object functionality.
delete-around() {
    zle delete-in
    zle vi-backward-char
    zle vi-delete-char
    zle vi-delete-char
}
zle -N delete-around

# Delete all characters between a pair of characters as well as the surrounding
# characters themselves and then go into insert mode Mimics Vim's "ca" text
# object functionality.
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

# The hackneyed <Nop> bind.
nop() {}
zle -N nop

# Use clipboard rather than system registers.
prepend-x-selection () {
    RBUFFER=$(xsel -op </dev/null)$RBUFFER;
    zle vi-end-of-line
}
zle -N prepend-x-selection
append-x-selection () {
    zle vi-forward-char
    RBUFFER=$(xsel -op </dev/null)$RBUFFER;
    zle vi-end-of-line
}
zle -N append-x-selection
yank-x-selection () {
    print -rn -- $CUTBUFFER | xsel -ip;
}
zle -N yank-x-selection

# }}}
# The Vim setup. {{{
# -----------------------------------------------------------------------------

# Vi(m) baby.
bindkey -v

# Disable flow control. Specifically, ensure that ctrl-s does not stop
# terminal flow so that it can be used in other programs (such as Vim).
setopt noflowcontrol
stty -ixon

# Disable use of ^D.
stty eof undef

# 1 sec <Esc> time delay? zsh pls.
# Set to 10ms for key sequences. (Note "bindkey -rp '^['" removes the
# availability of any '^[...' mappings, so use this instead.)
KEYTIMEOUT=1

# Vim insert mode mappings.
bindkey -M viins "^?" backward-delete-char      # i_Backspace
bindkey -M viins '^[[3~' delete-char            # i_Delete
bindkey -M viins '^[[Z' reverse-menu-complete   # i_SHIFT-Tab

# Vim insert mode mappings I don't use but nice to have.
bindkey -M viins "^A" beginning-of-line         # i_CTRL-A
bindkey -M viins "^E" end-of-line               # i_CTRL-E
bindkey -M viins "^N" down-line-or-history      # i_CTRL-N
bindkey -M viins "^P" up-line-or-history        # i_CTRL-P
bindkey -M viins "^H" backward-delete-char      # i_CTRL-H
bindkey -M viins "^B" _history-complete-newer   # i_CTRL-B
bindkey -M viins "^F" _history-complete-older   # i_CTRL-F
bindkey -M viins "^U" backward-kill-line        # i_CTRL-U
bindkey -M viins "^W" backward-kill-word        # i_CTRL-W
bindkey -M viins "^[[7~" vi-beginning-of-line   # i_Home
bindkey -M viins "^[[8~" vi-end-of-line         # i_End

# Custom Vim insert mode mappings I use everywhere.
bindkey -M viins '^V' append-x-selection        # i_CTRL-V
bindkey -M viins "^J" vim-down-line-or-history  # i_CTRL-J
bindkey -M viins "^K" vim-up-line-or-history    # i_CTRL-K
bindkey -M viins '^[[5~' nop                    # i_PgUp
bindkey -M viins '^[[6~' nop                    # i_PgDn

# Editing the line in veritable Vim.
autoload edit-command-line
zle -N edit-command-line
bindkey -M viins "^O" edit-command-line         # i_CTRL-I

# Vim normal mode mappings.
bindkey -M vicmd "ca" change-around             # ca
bindkey -M vicmd "ci" change-in                 # ci
bindkey -M vicmd "cc" vi-change-whole-line      # cc
bindkey -M vicmd "da" delete-around             # da
bindkey -M vicmd "di" delete-in                 # di
bindkey -M vicmd "dd" kill-whole-line           # dd
bindkey -M vicmd "gg" beginning-of-buffer-or-history # gg
bindkey -M vicmd "G" end-of-buffer-or-history   # G
bindkey -M vicmd "^R" redo                      # CTRL-R
#Temporary until I can get them to scroll the buffer.
#Note zshrc cannot physically do this, but urxvt itself cannot detect vicmd/viins apart..
bindkey -M vicmd "j" nop                        # j
bindkey -M vicmd "k" nop                        # k

# Vim normal mode mappings I don't use but nice to have.
bindkey -M vicmd "^E" vi-add-eol                # CTRL-E
bindkey -M vicmd "g~" vi-oper-swap-case         # g~
bindkey -M vicmd "ga" what-cursor-position      # ga

# Custom Vim normal mode mappings I use everywhere.
bindkey -M vicmd 'p' append-x-selection         # p
bindkey -M vicmd 'P' prepend-x-selection        # P
bindkey -M vicmd 'y' yank-x-selection           # y
#bindkey -M vicmd 'Y' yank-to-end-x-selection    # Y
bindkey -M vicmd "z" vi-substitute              # z
bindkey -M vicmd '^?' nop                       # Backspace
bindkey -M vicmd '^[[3~' nop                    # Delete
bindkey -M vicmd '^[[2~' nop                    # Insert
bindkey -M vicmd '^[[5~' nop                    # PgUp
bindkey -M vicmd '^[[6~' nop                    # PgDn

# }}}
# Alias, Environment Variables, & Functions {{{
# -----------------------------------------------------------------------------

###############################################################################
# Alias
###############################################################################

# Disable autocorrection for these.
alias ln="nocorrect ln"
alias mv='nocorrect mv'
alias mkdir='nocorrect mkdir'
alias sudo='nocorrect sudo'

# Default flags.
alias ping="ping -c 5"                  # Ping 5 packets, not unlimited.
alias crontab="EDITOR=vim crontab"      # Since crontab doesn't work with gvim/detached editors.
alias cp="nocorrect cp -Rv"             # Ensure that cp is always recursive and verbose.
alias df="df -h"                        # Display sizes in human readable format.
alias du="du -h -c"                     # Display sizes in human readable format, and total.
alias mount="sudo mount"                # Don't require prepending sudo.
alias umount="sudo umount"              # Don't require prepending sudo.
alias poweroff="sudo poweroff"          # Don't require prepending sudo.
alias reboot="sudo reboot"              # Don't require prepending sudo.
alias s="nocorrect sudo "               # Don't prompt me!
alias date="date +'%A %B %e %l:%M %P'"  # A nicer date format.
alias weather="weather 94704"           # Weather me.
alias zip="zip -r"                      # Zip recursively faget.

# Custom commands.
alias audio-toggle="bash ~/.config/nil/scripts/audio-toggle"
alias bd="bg && disown"
alias fonts="fc-cache -vf"              # Because 'fonts' is faster.
alias history='fc -l'
alias so="exec zsh"
alias xrdbx="xrdb ~/.Xresources"
alias sv="sudo vim"

# Directory navigation.
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'
alias -- --='cd -2'
alias -- ---='cd -3'

# Pacman/Packer aliases.
alias p="sudo pacman"
alias pa="packer --noedit"
alias pl="comm -23 <(pacman -Qeq|sort) <(pacman -Qgq base base-devel|sort)"
alias pqs="pacman -Qs"
alias prns="sudo pacman -Rns"
alias pr="sudo pacman -R"
alias ps="packer --noedit -S"
alias psyu="packer --noedit -Syu"
alias pss="packer -Ss"

# System-dotfile backups.
alias plx="comm -23 <(pacman -Qeq|sort) <(pacman -Qgq base base-devel|sort) > ~/.config/nil/system-dotfiles/package-list"
alias systemctlx="systemctl --all > ~/.config/nil/system-dotfiles/systemctl"
alias crontablx="crontab -l > ~/.config/nil/system-dotfiles/nil"

# CLI Applications
alias alsi="clear && alsi -a -c1=white -c2=unboldblue"
alias pipes="~/.config/nil/scripts/pipes.sh"
alias scrot="scrot -c -d 5 ~/nil/Media/Pictures/Screenshots/%Y-%m-%d-%T.png"
alias tcli="~/.config/nil/scripts/nil-transmission-remote-cli"

# Application Opening
l() { nocorrect f -e libreoffice "$@" & }
m() { nocorrect f -e mplayer2 "$@" & }
alias nitrogen="nitrogen &"
alias v="nocorrect f -e gvim -B viminfo"
alias virtualbox="virtualbox &"
z() { nocorrect f -e zathura "$@" & }

# le git.
alias ga="git add -f"
alias gc="git commit -a -m"         # Don't forget to add quotes.
alias gp="git push -u origin master"
alias gr="git rm --cached"
alias gs="git show --name-only"

# Manual mounter for now.
alias mounte="mount /dev/sdb1 /media/External_Hard_Drive"
alias umounte="umount /media/External_Hard_Drive"

###############################################################################
# Environment variables
###############################################################################

export EDITOR=gvim

# Open all man pages in Vim, under uneditable settings.
# Adding 'q' as the universal CLI shortcut for exit.
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 fdm=indent nomod noma nolist nonu nornu' -c 'nnoremap q :q<CR>' -\""

###############################################################################
# Functions
###############################################################################

# Echo external IP and what your NIC thinks your IP addresses are.
exip () {
    # gather external ip address
    echo -n "Current External IP: "
    curl -s -m 5 http://myip.dk | grep "ha4" | sed -e 's/.*ha4">//g' -e 's/<\/span>.*//g'
}
ips () {
    # determine local IP address
    ifconfig | grep "inet " | awk '{ print $2 }'
}

# A python-adapted calc program.
alias calc='python -ic "from __future__ import division; from math import *; from random import *"'

# }}}

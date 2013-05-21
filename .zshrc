#
# zsh dotfile
# ~/.zshrc
# Name: nil
#
# Oh my zsh setup. {{{
# -----------------------------------------------------------------------------

# Path to your oh-my-zsh configuration.
ZSH=/usr/share/oh-my-zsh/
export ZSH_CUSTOM=~/.config/nil/oh-my-zsh-custom

# Theme.
ZSH_THEME="nil"

# What a Windows/Mac feature.
DISABLE_AUTO_UPDATE="true"

# Enable red dots while waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Default file path: /usr/share/oh-my-zsh/plugins
# Custom file path: ~/.config/nil/oh-my-zsh-custom/plugins
plugins=(git fasd)

source $ZSH/oh-my-zsh.sh

# }}}
# Autocorrections. {{{
# -----------------------------------------------------------------------------

#DISABLE_CORRECTION="true"

# Autocorrection for git.
#git config --global help.autocorrect 1

# Disable autocorrection for these.
alias mkdir="nocorrect mkdir"
alias cp="nocorrect cp"
alias mv="nocorrect mv"
alias ln="nocorrect ln"

# }}}
# Defaults I would like to keep track of should I ever decide to graduate from omz. {{{
# -----------------------------------------------------------------------------

# If non-ambiguous, allow changing into a directory just by typing its name.
setopt autocd

# Detect and prompt to correct typos in commands.
# Note there is a "correctall" varient which also prompts to correct arguments
# to commands, but this ends up being more troublesome than useful.
setopt correct

# When offering typo corrections, do not propose anything which starts with an
# underscore (such as many of Zsh's shell functions).
CORRECT_IGNORE='_*'

# Enable extended globbing functionality.
setopt extendedglob

# Disables the beep Zsh would otherwise make when giving invalid input (such as
# hitting backspace on an command line).
setopt nobeep

# Do not warn about closing the shell with background jobs running.
setopt nocheckjobs

# History.
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zshinfo
# Do not record repeated lines in history.
setopt histignoredups
# Share history between shells.
setopt share_history

# Allow comments on the command line. Without this comments are only allowed
# in scripts.
setopt interactivecomments

# Do not consider "/" a word character. One benefit of this is that when
# hitting ctrl-w in insert mode (which deletes the word before the cursor) just
# before a filesystem path, it only removes the last item of the path and not
# the entire thing.
WORDCHARS=${WORDCHARS//\/}

# }}}
# zle widgets. {{{
# -----------------------------------------------------------------------------
# The ZLE widges are all followed by "zle -<MODE> <NAME>" and bound below in
# the "Key Bindings" section.

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
}
zle -N prepend-x-selection
append-x-selection () {
    zle vi-forward-char
    RBUFFER=$(xsel -op </dev/null)$RBUFFER;
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
# Mapped in line with pentadactyl.
autoload edit-command-line
zle -N edit-command-line
bindkey -M viins "^I" edit-command-line         # i_CTRL-I

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
# Oh my alias. {{{
# -----------------------------------------------------------------------------

alias audio-toggle="bash ~/.config/nil/audio-toggle"
alias bd="bg && disown"
alias poweroff="sudo poweroff"
alias reboot="sudo reboot"
alias s="sudo "
alias so="source ~/.zshrc"
alias date="date +'%A %B %e %l:%M %P'"

# Pacman/Packer aliases.
p() { sudo pacman -$^@; }
alias pa="packer --noedit"
alias pl="comm -23 <(pacman -Qeq|sort) <(pacman -Qgq base base-devel|sort)"
alias plx="comm -23 <(pacman -Qeq|sort) <(pacman -Qgq base base-devel|sort) > ~/.config/nil/package-list"
alias pqs="pacman -Qs"
alias prns="sudo pacman -Rns"
alias pr="sudo pacman -R"
alias ps="sudo pacman -S"
alias psyu="packer --noedit -Syu"
alias pss="pacman -Ss"

# A temporary workaround until I set a udev automount rule.
alias sm="sudo mount /dev/sdb1 /mnt/ext"

# Applications
l() { nocorrect f -e libreoffice "$@" & }
m() { nocorrect f -e mplayer2 "$@" & }
alias nitrogen="nitrogen &"
alias scrot="scrot -c -d 5 ~/Dropbox/nil/Media/Pictures/Screenshots/%Y-%m-%d-%T.png"
alias sv="sudo vim"
alias un="urxvt -name nil -g 80x24 &"
alias lun="urxvt -name nil -g 110x30 &"
alias Lun="urxvt -name nil -g 147x37 &"
alias v="nocorrect f -e gvim -B viminfo"
z() { nocorrect f -e zathura "$@" & }

# le git.
alias ga="git add -f"
alias gc="git commit -a -m"
alias gp="git push -u origin master"
alias gr="git rm --cached"
alias gs="git show --name-only"

# }}}
# Environment variables.
export EDITOR=gvim
# Open all man pages in Vim, under uneditable settings. FoldAllToggle() lets me fold at will without having folds on startup, and 'q' gives me easy access to exit.
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 fdm=indent nomod noma nolist nonu nornu' -c 'call FoldAllToggle()' -c 'nnoremap q :q<CR>' -\""

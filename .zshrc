#
# zsh dotfile
# ~/.zshrc
# Name: nil
#
# General Settings {{{
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

###############################################################################
# History
###############################################################################

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

###############################################################################
# Cache
###############################################################################

CACHEDIR="$HOME/.cache/zsh-cache"

fasd_cache="$HOME/.cache/.fasd-init-cache"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init auto >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

# }}}
# Completion {{{
# -----------------------------------------------------------------------------

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
# Prompt Style {{{
# -----------------------------------------------------------------------------
# This changes PS1 dynamically depending on insert or command mode.

autoload -U colors && colors
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
# zle widgets {{{
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
autoload edit-command-line
zle -N edit-command-line

# }}}
# The Vim setup {{{
# -----------------------------------------------------------------------------

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

###############################################################################
# Insert mode
###############################################################################

bindkey -M viins "^?" backward-delete-char      # i_Backspace
bindkey -M viins '^[[3~' delete-char            # i_Delete
bindkey -M viins '^[[Z' reverse-menu-complete   # i_SHIFT-Tab

# Non-Vim default mappings I use everywhere.
bindkey -M viins "^N" vim-down-line-or-history  # i_CTRL-N
bindkey -M viins "^E" vim-up-line-or-history    # i_CTRL-E
bindkey -M viins '^V' append-x-selection        # i_CTRL-V

# Vim defaults I don't use but I may as well keep.
bindkey -M viins "^A" beginning-of-line         # i_CTRL-A
#bindkey -M viins "^E" end-of-line               # i_CTRL-E
bindkey -M viins "^K" down-line-or-history      # i_CTRL-N
bindkey -M viins "^P" up-line-or-history        # i_CTRL-P
bindkey -M viins "^H" backward-delete-char      # i_CTRL-H
bindkey -M viins "^B" _history-complete-newer   # i_CTRL-B
bindkey -M viins "^F" _history-complete-older   # i_CTRL-F
bindkey -M viins "^U" backward-kill-line        # i_CTRL-U
bindkey -M viins "^W" backward-kill-word        # i_CTRL-W
bindkey -M viins "^[[7~" vi-beginning-of-line   # i_Home
bindkey -M viins "^[[8~" vi-end-of-line         # i_End

# Edit current line in veritable Vim.
bindkey -M viins "^H" edit-command-line         # i_CTRL-I

###############################################################################
# Normal mode
###############################################################################

bindkey -M vicmd "ca" change-around             # ca
bindkey -M vicmd "ci" change-in                 # ci
bindkey -M vicmd "cc" vi-change-whole-line      # cc
bindkey -M vicmd "da" delete-around             # da
bindkey -M vicmd "di" delete-in                 # di
bindkey -M vicmd "dd" kill-whole-line           # dd
bindkey -M vicmd "gg" beginning-of-buffer-or-history # gg
bindkey -M vicmd "G" end-of-buffer-or-history   # G
bindkey -M vicmd "^R" redo                      # CTRL-R

# Colemak.
bindkey -M vicmd "s" backward-char              # i_s
bindkey -M vicmd "t" forward-char               # i_t
#Note zshrc cannot physically do this, but urxvt itself cannot detect vicmd/viins apart..
#bindkey -M vicmd "n" SCROLL DAMMIT!!            # n
#bindkey -M vicmd "e" SCROLL DAMMIT!!            # e

# Non-Vim default mappings I use everywhere.
bindkey -M vicmd 'p' append-x-selection         # p
bindkey -M vicmd 'P' prepend-x-selection        # P
bindkey -M vicmd 'y' yank-x-selection           # y
#bindkey -M vicmd 'Y' yank-to-end-x-selection    # Y
bindkey -M vicmd "z" vi-substitute              # z

# Vim defaults I don't use but I may as well keep.
bindkey -M vicmd "^H" vi-add-eol                # CTRL-E
bindkey -M vicmd "g~" vi-oper-swap-case         # g~
bindkey -M vicmd "ga" what-cursor-position      # ga

# }}}
# Alias & Functions {{{
# -----------------------------------------------------------------------------

###############################################################################
# Alias
###############################################################################

# Colors.
alias ls='ls -a --color'
alias lsl='ls -lah --color'
alias grep='grep --color'

# Disable autocorrection for these.
alias ln="nocorrect ln"
alias mv='nocorrect mv'
alias mkdir='nocorrect mkdir'
alias sudo='nocorrect sudo'

# Default flags.
alias ping="ping -c 5 www.google.com"      # The only reason I ever use ping.
alias crontab="EDITOR=vim crontab"         # Since crontab doesn't work with gvim/detached editors.
alias cp="nocorrect cp -Rv"                # Ensure that cp is always recursive and verbose.
alias df="df -h"                           # Display sizes in human readable format.
alias du="du -h -c"                        # Display sizes in human readable format, and total.
alias mpd="mpd ~/.config/mpd/mpd.conf"     # Default directory for configuration files.
alias mount="sudo mount"                   # Don't require prepending sudo.
alias umount="sudo umount"                 # Don't require prepending sudo.
alias youtube-dl="youtube-dl -citk --max-quality FORMAT --extract-audio --audio-format mp3" # Download with audio and things.

# Computing Environment default flags.
alias matlab="matlab -nodesktop -nosplash" # Run matlab in terminal (but with GUI support in, say, plots), hide splash
                                           # startup.
alias R="R --no-save -q"                   # Never save workspace image, hide startup message.
alias python="python -q"                   # Hide startup message.

# Power Management Controls.
alias poweroff="sudo poweroff"             # Don't require prepending sudo.
alias reboot="sudo reboot"                 # Don't require prepending sudo.
alias suspend="sudo pm-suspend-hybrid"     # Don't require prepending sudo. Also the best low power suspension state.
alias xsetd="xset dpms force off"          # Turn off display.

# Miscellaneous custom commands.
alias bd="bg && disown"                    # Best way to prevent terminal-launched app from dying when closing terminal.
alias fonts='mkfontdir ~/.fonts;mkfontscale ~/.fonts;xset +fp ~/.fonts;xset fp rehash;fc-cache;fc-cache -fv'
alias history='fc -l'                      # See list of recently used commands.
alias psc="ps -C"
alias rm='echo "This is not the command you are looking for."; false' #Never use rm again.
alias speedtest="wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip"
alias sv="sudo vim"
alias wifi="sudo systemctl restart netctl-auto@wlan0.service"

# Restart configs.
alias so="exec zsh"
alias xrdbx="xrdb ~/.Xresources"

# Directory navigation.
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'
alias -- --='cd -2'
alias -- ---='cd -3'

# Manual file backups into ~/doc.
alias plx="echo 'This lists any installed packages that are not in the base or base-devel group, and hence are likely \
installed manually by\n me. See ~/.zshrc for the command.\n' > ~/doc/package-list\
&& (comm -23 <(pacman -Qeq|sort) <(pacman -Qgq base base-devel|sort)\
&& echo 'matlab r-2012b (\"make install\")') | sort >> ~/doc/package-list"
# totally not sort ordered correctly, e.g., "X.5 " shown before "X - "
alias catalog=" ( find '/media/sdb1' -type d -not -path '*/\[Backlog\]/*'\
        | sed -e 's/^\/media\/sdb1\///' -e '/^\/media\/sdb1/d'\
        | sed -e 's/\[Backlog\]/\[aaBacklog\]/' -e 's/\[Films\]/\[aaFilms\]/'\
        && echo 'Anime/[aaBacklog]/...
Anime/[aaBacklog]/[Completed]
Anime/[aaBacklog]/[Completed]/...
Anime/[aaBacklog]/[Current]
Anime/[aaBacklog]/[Current]/...
Anime/[aaBacklog]/[Winter 2014]
Anime/[aaBacklog]/[Winter 2014]/...
Films/[aaBacklog]/...
Films/[aaBacklog]/[Completed]
Films/[aaBacklog]/[Completed]/...
Literature/[aaBacklog]/...
Literature/[aaBacklog]/[Completed]
Literature/[aaBacklog]/[Completed]/...
Manga/[aaBacklog]/...
Manga/[aaBacklog]/[Completed]
Manga/[aaBacklog]/[Completed]/...
Manga/[aaBacklog]/[Current]
Manga/[aaBacklog]/[Current]/...
Music/[aaBacklog]/...
Music/[aaBacklog]/[Completed]
Music/[aaBacklog]/[Completed]/...
TV/[aaBacklog]/...
TV/[aaBacklog]/[Completed]
TV/[aaBacklog]/[Completed]/...
Video Games/[aaBacklog]/...
Video Games/[aaBacklog]/[Completed]
Video Games/[aaBacklog]/[Completed]/...
Visual Novels/[aaBacklog]/...
Visual Novels/[aaBacklog]/[Completed]
Visual Novels/[aaBacklog]/[Completed]/...' )\
        | sort\
        | sed -e 's/\[aaBacklog\]/\[Backlog\]/' -e 's/\[aaFilms\]/\[Films\]/'\
        | sed -e 's/^\(Anime\|Films\|Literature\|Manga\|Music\|TV\|Video Games\|Visual Novels\)$/\n&/'\
        | sed -e '1i This lists the entire directory structure of my ~/nil/Media folder, which is a collection\
 of all titles I rate >=8/10 and\n their affiliated installments. It also stores my massive backlogs within each\
 medium, but I omit them here. Why archive\n my Media directory structure, you ask? Because its so pretty and\
 autistic of me I simply must. When youre a consumer,\n there ought to be a competent way to organize your\
 collection. See ~/.zshrc for the command.'\
        > ~/doc/media-catalog"

# Manual file backups into ~/system-dotfiles.
alias groupsx="groups > ~/system-dotfiles/groups"
alias systemctlx="systemctl --all > ~/system-dotfiles/systemctl"

# le git.
alias ga="git add -f"
alias gc="git commit -a -m"
alias gp="git push -u origin master"
alias gr="git rm --cached"
alias gs="git status"

# Manual mounter.
alias mountb="mount /dev/sdb1 /media/sdb1"
alias mountc="mount /dev/sdc1 /media/sdc1"
alias umountb="umount /media/sdb1"
alias umountc="umount /media/sdc1"

# Package management.
alias pl="comm -23 <(pacman -Qeq|sort) <(pacman -Qgq base base-devel|sort)"
alias pQs="pacman -Qs"
alias pR="sudo pacman -R"
alias pRcns="sudo pacman -Rcns"
alias pS="packer --noedit -S"
alias pSyu="packer --noedit -Syu"
alias pSs="packer -Ss"

# trash-cli.
alias tp="trash-put"
alias tl="trash-list"
alias tr="restore-trash"
alias emptytrash="trash-empty"

# CLI Applications.
alias alsi="clear && alsi -a -c1=unboldred -c2=unboldred"
alias scrot="scrot -c -d 3 ~/nil/Media/Pictures/Screencaps/scrot/%Y-%m-%d-%T.png"
alias byzanz-record="cd ~/nil/Media/Pictures/Screencaps/byzanz && byzanz-record -c -d 10 nil.gif && cd -"

###############################################################################
# Functions
###############################################################################

# The best zip! Don't include parent folders, don't nest zip function, zip recursively, and auto-take zip's second argument
# as first.
zip() {
    name="$(basename -- "$1")"
    cd "$(dirname -- "$1")" &&
    command zip -r "$name.zip" "$name"
}

# Application Opening
l() { nocorrect f -e libreoffice "$@" & }
m() { nocorrect f -e mpv "$@" & }
alias v="nocorrect f -e gvim -B viminfo"
z() { nocorrect f -e zathura "$@" & }

# School SSH
alias sshb="ssh -X s243-10@arwen.berkeley.edu"
function scpb() {
    scp -r $1 s243-10@arwen.berkeley.edu:~/$2
}

# Tablet SSH.
# The obtuse folder directory is to copy manga files directly into my comic reader app. I specify "all arguments" so it
# can scp multiple files/directories simultaneously, if desired.
function scpt() {
    scp -r "$@" mobile@192.168.1.115:/var/mobile/Applications/08D6B83A-D6A0-4B4E-9334-86A0A99BD891/Documents/
    #temp setting for vacation
    #scp -r "$@" mobile@192.168.1.9:/var/mobile/Applications/08D6B83A-D6A0-4B4E-9334-86A0A99BD891/Documents/
}
# This one goes to my pdf reader app.
function scpp() {
    scp -r "$@" mobile@192.168.1.115:/var/mobile/Applications/55560426-B2FC-4F26-ACF0-D95A18D965BB/Documents/
    #temp setting for vacation
    #scp -r "$@" mobile@192.168.1.9:/var/mobile/Applications/55560426-B2FC-4F26-ACF0-D95A18D965BB/Documents/
}

# }}}

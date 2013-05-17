#
# zsh dotfile
# ~/.zshrc
# Name: nil
#

# Path to your oh-my-zsh configuration.
ZSH=/usr/share/oh-my-zsh/

# Theme.
ZSH_THEME="nil"

# What a Windows/Mac feature.
DISABLE_AUTO_UPDATE="true"

# Autocorrection.
DISABLE_CORRECTION="true"
# Somehow disable it just for fasd commands, e.g., some easy way to handle an exclude list.

# Autocorrection for git.
git config --global help.autocorrect 1

# Enable red dots while waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Default file path: /usr/share/oh-my-zsh/plugins
# Custom file path: ~/.config/nil/oh-my-zsh-custom/plugins
plugins=(git fasd)

source $ZSH/oh-my-zsh.sh

# Vi(m) baby.
bindkey -v

# Uh, please work like Vim (or any sane person), not like Vi.
bindkey    "^?"    backward-delete-char   # Backspace
bindkey    '^[[3~' delete-char            # Delete
bindkey -a "^?"    backward-delete-char
bindkey -a '^[[3~' delete-char
bindkey -a u       undo
bindkey -a '^R'    redo
bindkey    '^[[Z'  reverse-menu-complete

# I don't actually use these ones, but at least it's more Vim behavior.
bindkey    "^[[7~" vi-beginning-of-line   # Home
bindkey    "^[[8~" vi-end-of-line         # End
bindkey -a 'gg'    beginning-of-buffer-or-history
bindkey -a 'g~'    vi-oper-swap-case
bindkey -a G       end-of-buffer-or-history
bindkey    "^P"    vi-up-line-or-history
bindkey    "^N"    vi-down-line-or-history

# My custom Vim commands.
bindkey     "^J"   vi-down-line-or-history
bindkey     "^K"   vi-up-line-or-history

# Oh my alias commands.
alias audio-toggle="bash ~/.config/nil/audio-toggle"
alias bd="bg && disown"
alias p="sudo pacman"
alias pl="comm -23 <(pacman -Qeq|sort) <(pacman -Qgq base base-devel|sort)"
alias poweroff="sudo poweroff"
alias reboot="sudo reboot"
alias so="source ~/.zshrc"

# A temporary workaround until I set a udev automount rule.
alias sm="sudo mount /dev/sdb1 /mnt/ext"

# Applications
l() { f -e libreoffice "$@" & }
m() { f -e mplayer2 "$@" & }
z() { f -e zathura "$@" & }
alias nitrogen="nitrogen &"
alias sv="sudo vim"
alias scrot="scrot -c -d 5 ~/Dropbox/nil/Media/Pictures/Screenshots/%Y-%m-%d-%T.png"
alias un="urxvt -name nil"
alias v="f -e gvim -B viminfo"

# le git.
alias ga="git add -f"
alias gc="git commit -a -m"
alias gp="git push -u origin master"
alias gcp="git commit -a -m '~' && git push -u origin master"
alias gr="git rm --cached"
alias gs="git show --name-only"

# Environment variables.
export EDITOR=gvim
export ZSH_CUSTOM=~/.config/nil/oh-my-zsh-custom

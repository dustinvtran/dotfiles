#
# zsh dotfile
# ~/.zshrc
# Name: nil
#
# Oh my zsh setup. {{{
# -----------------------------------------------------------------------------

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

# }}}
# Oh my keybindings. {{{
# -----------------------------------------------------------------------------

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

# }}}
# Oh my alias. {{{
# -----------------------------------------------------------------------------

alias audio-toggle="bash ~/.config/nil/audio-toggle"
alias bd="bg && disown"
alias poweroff="sudo poweroff"
alias reboot="sudo reboot"
alias s="sudo "
alias so="source ~/.zshrc"
# Temporarily using this and 'cal' until I can set up a time widget that popups cal when I hit a command.
alias time="date +'%A %B %e %l:%M %p'"

# Pacman/Packer aliases.
p() { sudo pacman -$^@; }
alias pa="packer --noedit"
alias pl="comm -23 <(pacman -Qeq|sort) <(pacman -Qgq base base-devel|sort)"
alias plx="comm -23 <(pacman -Qeq|sort) <(pacman -Qgq base base-devel|sort) > ~/system-dotfiles/pkglist"
alias pqs="pacman -Qs"
alias prns="sudo pacman -Rns"
alias pr="sudo pacman -R"
alias ps="sudo pacman -S"
alias psyu="packer -Syu"
alias pss="pacman -Ss"

# A temporary workaround until I set a udev automount rule.
alias sm="sudo mount /dev/sdb1 /mnt/ext"

# Applications
l() { f -e libreoffice "$@" & }
m() { f -e mplayer2 "$@" & }
alias nitrogen="nitrogen &"
alias scrot="scrot -c -d 5 ~/Dropbox/nil/Media/Pictures/Screenshots/%Y-%m-%d-%T.png"
alias sv="sudo vim"
alias un="urxvt -name nil"
alias v="f -e gvim -B viminfo"
z() { f -e zathura "$@" & }

# le git.
alias ga="git add -f"
alias gc="git commit -a -m"
alias gp="git push -u origin master"
alias gr="git rm --cached"
alias gs="git show --name-only"

# }}}
# Environment variables.
export EDITOR=gvim
export ZSH_CUSTOM=~/.config/nil/oh-my-zsh-custom

# Functions.

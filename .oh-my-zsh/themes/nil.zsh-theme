#
# zsh theme
# ~/.oh-my-zsh/themes/nil.zsh-theme
# Name: nil
# Description: A minimalistic approach to determining the current Vi mode.
#

# One caveat I haven't figured out: when pressing <CR> while still in cmd mode (blue), the directory stays the cmd-color. I would like the color to reset back to the default (red) before <CR> is hit, so that it's /always/ the default (red) unless I'm in cmd mode (blue).

PROMPT='%n %{$fg[red]%}%c %{$reset_color%}'
zle-keymap-select () {
if [[ $TERM == "rxvt-unicode" || $TERM == "rxvt-unicode-256color" ]]; then
    if [ $KEYMAP = vicmd ]; then
        PROMPT='%n %{$fg[blue]%}%c %{$reset_color%}'
        () { return $__prompt_status }
        zle reset-prompt
    else
        PROMPT='%n %{$fg[red]%}%c %{$reset_color%}'
        () { return $__prompt_status }
        zle reset-prompt
    fi
fi
}
zle -N zle-keymap-select

zle-line-init () {
    zle -K viins
    if [[ $TERM == "rxvt-unicode" || $TERM = "rxvt-unicode-256color" ]]; then
        PROMPT='%n %{$fg[red]%}%c %{$reset_color%}'
        () { return $__prompt_status }
        zle reset-prompt
    fi
}
zle -N zle-line-init

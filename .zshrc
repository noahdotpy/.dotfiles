# declare a list of expandable aliases to fill up later
typeset -a ealiases
ealiases=()

# write a function for adding an alias to the list mentioned above
function abbrev-alias() {
    alias $1
    export $1
    ealiases+=(${1%%\=*})
}

# expand any aliases in the current line buffer
function expand-ealias() {
    if [[ $LBUFFER =~ "\<(${(j:|:)ealiases})\$" ]]; then
        zle _expand_alias
        zle expand-word
    fi
    zle magic-space
}
zle -N expand-ealias

# Bind the space key to the expand-alias function above, so that space will expand any expandable aliases
bindkey ' '        expand-ealias
bindkey '^ '       magic-space     # control-space to bypass completion
bindkey -M isearch " "      magic-space     # normal space during searches

# A function for expanding any aliases before accepting the line as is and executing the entered command
expand-alias-and-accept-line() {
    expand-ealias
    zle .backward-delete-char
    zle .accept-line
}
zle -N accept-line expand-alias-and-accept-line


# SET ENVIRONMENTAL VARIABLES
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="librewolf"

# ADD ABBREVIATIONS

# Config shortcuts
abbrev-alias conf="~/.config"
abbrev-alias dots="~/.dotfiles"
abbrev-alias zshrc="~/.zshrc"
abbrev-alias alconf="~/.config/alacritty/"
abbrev-alias dunstconf="~/.config/dunst"
abbrev-alias fishconf="~/.config/fish"
abbrev-alias swayconf="~/.config/sway"
abbrev-alias roficonf="~/.config/rofi"
abbrev-alias i3conf="~/.config/i3"
abbrev-alias nvconf="~/.config/nvim"
abbrev-alias pbconf="~/.config/polybar"
abbrev-alias bspwmconf="~/.config/bspwm"
abbrev-alias qtileconf="~/.config/qtile"
abbrev-alias sxhkdconf="~/.config/sxhkd"

# NixOS shortcuts
abbrev-alias nixc="/home/noah/.dotfiles/nixos-system/"

abbrev-alias nixupd="~/.scripts/github.com/noahdotpy/.dotfiles/nixos-update"
abbrev-alias nixapply="~/.scripts/github.com/noahdotpy/.dotfiles/users-apply && ~/.scripts/github.com/noahdotpy/.dotfiles/system-apply"
abbrev-alias nixapplysys="~/.scripts/github.com/noahdotpy/.dotfiles/system-apply"
abbrev-alias nixapplyusrs="~/.scripts/github.com/noahdotpy/.dotfiles/users-apply"

# NixOS Home Manager shortcuts
abbrev-alias hman="home-manager"
abbrev-alias hmanc="/home/noah/.dotfiles/nixos-homemanager"

# Program shortcuts
abbrev-alias e="$EDITOR"

abbrev-alias nv="nvim"
abbrev-alias sv="spacevim"
abbrev-alias svim="spacevim"
abbrev-alias emacsc="emacsclient -c -a 'emacs'"
abbrev-alias py="python3"

# Filesystem shortcuts
abbrev-alias gosrc="~/go/src"
abbrev-alias cproj="~/CodeProjects"
abbrev-alias cprojpy="~/CodeProjects/Python"
abbrev-alias ideaproj="~/IdeaProjects"
abbrev-alias pyproj="~/PycharmProjects"

abbrev-alias dl="~/Downloads"
abbrev-alias dls="~/Downloads"
abbrev-alias downloads="~/Downloads"
abbrev-alias docs="~/Documents"
abbrev-alias documents="~/Documents"
abbrev-alias pics="~/Pictures"
abbrev-alias pictures="c/Pictures"
abbrev-alias walls="~/Pictures/Wallpapers"
abbrev-alias wallpapers="~/Pictures/Wallpapers"
abbrev-alias vids="~/Videos"
abbrev-alias videos="~/Videos"


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

if [ -e /home/noah/.nix-profile/etc/profile.d/nix.sh ]; then . /home/noah/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

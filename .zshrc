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
abbrev-alias conf="$HOME/config"
abbrev-alias dots="$HOME/.dotfiles"
abbrev-alias zshrc="$HOME/.zshrc"
abbrev-alias alconf="$HOME/.config/alacritty/"
abbrev-alias dunstconf="$HOME/.config/dunst"
abbrev-alias fishconf="$HOME/.config/fish"
abbrev-alias swayconf="$HOME/.config/sway"
abbrev-alias roficonf="$HOME/.config/rofi"
abbrev-alias i3conf="$HOME/.config/i3"
abbrev-alias nvconf="$HOME/.config/nvim"
abbrev-alias pbconf="$HOME/.config/polybar"
abbrev-alias bspwmconf="$HOME/.config/bspwm"
abbrev-alias qtileconf="$HOME/.config/qtile"
abbrev-alias sxhkdconf="$HOME/.config/sxhkd"

# NixOS shortcuts
abbrev-alias nixc="$HOME/.dotfiles/nixos-system/"

abbrev-alias nixupd="$HOME/.scripts/github.com/noahdotpy/.dotfiles/nixos-update"
abbrev-alias nixapply="$HOME/.scripts/github.com/noahdotpy/.dotfiles/users-apply && $HOME/.scripts/github.com/noahdotpy/.dotfiles/system-apply"
abbrev-alias nixapplysys="$HOME/.scripts/github.com/noahdotpy/.dotfiles/system-apply"
abbrev-alias nixapplyusrs="$HOME/.scripts/github.com/noahdotpy/.dotfiles/users-apply"

# NixOS Home Manager shortcuts
abbrev-alias hman="home-manager"
abbrev-alias hmanc="$HOME/.dotfiles/nixos-homemanager"

# Program shortcuts
abbrev-alias e="$EDITOR"

abbrev-alias nv="nvim"
abbrev-alias sv="spacevim"
abbrev-alias svim="spacevim"
abbrev-alias emacsc="emacsclient -c -a 'emacs'"
abbrev-alias py="python3"

# Filesystem shortcuts
abbrev-alias gosrc="$HOME/go/src"
abbrev-alias cproj="$HOME/CodeProjects"
abbrev-alias cprojpy="$HOME/CodeProjects/Python"
abbrev-alias ideaproj="$HOME/IdeaProjects"
abbrev-alias pyproj="$HOME/PycharmProjects"

abbrev-alias dl="$HOME/Downloads"
abbrev-alias dls="$HOME/Downloads"
abbrev-alias downloads="$HOME/Downloads"
abbrev-alias docs="$HOME/Documents"
abbrev-alias documents="$HOME/Documents"
abbrev-alias pics="$HOME/Pictures"
abbrev-alias pictures="$HOME/Pictures"
abbrev-alias walls="$HOME/Pictures/Wallpapers"
abbrev-alias wallpapers="$HOME/Pictures/Wallpapers"
abbrev-alias vids="$HOME/Videos"
abbrev-alias videos="$HOME/Videos"


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

if [ -e /home/noah/.nix-profile/etc/profile.d/nix.sh ]; then . /home/noah/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

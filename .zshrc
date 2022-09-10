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
# export EDITOR="nvim"
export EDITOR="spacevim"
export TERMINAL="kitty"
export BROWSER="librewolf"

# ADD ABBREVIATIONS

# Config shortcuts
abbrev-alias conf="cd ~/.config"
abbrev-alias edots="$EDITOR ~/.dotfiles"
abbrev-alias dots="cd ~/.dotfiles"
abbrev-alias zshrc="$EDITOR ~/.zshrc"
abbrev-alias ealconf="$EDITOR ~/.config/alacritty/"
abbrev-alias alconf="cd ~/.config/alacritty/"
abbrev-alias edunstconf="$EDITOR ~/.config/dunst"
abbrev-alias dunstconf="cd ~/.config/dunst"
abbrev-alias efishconf="$EDITOR ~/.config/fish"
abbrev-alias fishconf="cd ~/.config/fish"
abbrev-alias eswayconf="$EDITOR ~/.config/sway"
abbrev-alias swayconf="cd ~/.config/sway"
abbrev-alias eroficonf="$EDITOR ~/.config/rofi"
abbrev-alias roficonf="cd ~/.config/rofi"
abbrev-alias ei3conf="$EDITOR ~/.config/i3"
abbrev-alias i3conf="cd ~/.config/i3"
abbrev-alias envconf="$EDITOR ~/.config/nvim"
abbrev-alias nvconf="cd ~/.config/nvim"
abbrev-alias epbconf="$EDITOR ~/.config/polybar"
abbrev-alias pbconf="cd ~/.config/polybar"

# NixOS shortcuts
abbrev-alias enixc="$EDITOR /home/noah/.dotfiles/nixos-system/configuration.nix"

abbrev-alias nixupd="~/.dotfiles/.scripts/nixos-update"
abbrev-alias nixapply="~/.dotfiles/.scripts/users-apply && ~/.dotfiles/.scripts/system-apply"
abbrev-alias nixapplysys="~/.dotfiles/.scripts/system-apply"
abbrev-alias nixapplyusrs="~/.dotfiles/.scripts/users-apply"

# NixOS Home Manager shortcuts
abbrev-alias hman="home-manager"
abbrev-alias ehmanc="$EDITOR /home/noah/.dotfiles/nixos-homemanager"
abbrev-alias hmans="home-manager switch -f /home/noah/.dotfiles/nixos-homemanager/users/noah/home.nix"

# Program shortcuts
abbrev-alias e="$EDITOR"

abbrev-alias nv="nvim"
abbrev-alias sv="spacevim"
abbrev-alias svim="spacevim"
abbrev-alias py="python3"

# Filesystem shortcuts
abbrev-alias gosrc="cd ~/go/src"
abbrev-alias cproj="cd ~/CodeProjects"
abbrev-alias cprojpy="cd ~/CodeProjects/Python"
abbrev-alias ideaproj="cd ~/IdeaProjects"
abbrev-alias pyproj="cd ~/PycharmProjects"

abbrev-alias dl="cd ~/Downloads"
abbrev-alias dls="cd ~/Downloads"
abbrev-alias downloads="cd ~/Downloads"
abbrev-alias docs="cd ~/Documents"
abbrev-alias documents="cd ~/Documents"
abbrev-alias pics="cd ~/Pictures"
abbrev-alias pictures="cd ~/Pictures"
abbrev-alias walls="cd ~/Pictures/Wallpapers"
abbrev-alias wallpapers="cd ~/Pictures/Wallpapers"
abbrev-alias vids="cd ~/Videos"
abbrev-alias videos="cd ~/Videos"


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

if [ -e /home/noah/.nix-profile/etc/profile.d/nix.sh ]; then . /home/noah/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

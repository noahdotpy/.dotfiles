read -r DISTRO_NAME < /etc/os-release
DISTRO_NAME=$(echo "$DISTRO_NAME" | awk -F '=' '{print $2}' | sed 's/"//g')

# True iff all arguments are executable in $PATH
function is_bin_in_path {
  if [[ -n $ZSH_VERSION ]]; then
    builtin whence -p "$1" &> /dev/null
  else  # bash:
    builtin type -P "$1" &> /dev/null
  fi
  [[ $? -ne 0 ]] && return 1
  if [[ $# -gt 1 ]]; then
    shift  # We've just checked the first one
    is_bin_in_path "$@"
  fi
}

function clone-my-plugins() {
    plugin-clone github.com/zsh-users/zsh-syntax-highlighting
    plugin-clone github.com/zsh-users/zsh-history-substring-search
    plugin-clone github.com/zsh-users/zsh-autosuggestions
}

function plugin-clone() {
    PLUGIN_URL="$1"
    if [[ $PLUGIN_URL == "https://"* || $PLUGIN_URL == "http://"* ]]; then
        PLUGIN_FOLDER="$HOME/.zsh/plugins/$(echo $PLUGIN_URL | awk -F "://" '{print $2}')"
    else
        PLUGIN_FOLDER="$HOME/.zsh/plugins/$PLUGIN_URL"
        PLUGIN_URL="https://$PLUGIN_URL"
    fi
    git clone $PLUGIN_URL $PLUGIN_FOLDER
}

# declare a list of expandable aliases to fill up later
typeset -a ealiases
ealiases=()

# write a function for adding an alias to the list mentioned above
function abbrev() {
    alias $1
    export $1
    ealiases+=(${1%%\=*})
}

# expand any aliases in the current line buffer
function expand-ealias() {
    if [[ $LBUFFER =~ "\<(${(j:|:)ealiases})\$" ]] && [[ "$LBUFFER" != "\\"* ]]; then
        zle _expand_alias
        zle expand-word
    fi
    zle magic-space
}
zle -N expand-ealias

# Bind the space key to the expand-alias function above, so that space will expand any expandable aliases
bindkey ' '        expand-ealias
bindkey -M isearch " "      magic-space     # normal space during searches

# A function for expanding any aliases before accepting the line as is and executing the entered command
expand-alias-and-accept-line() {
    expand-ealias
    zle .backward-delete-char
    zle .accept-line
}
zle -N accept-line expand-alias-and-accept-line

setopt auto_cd

# SET ENVIRONMENTAL VARIABLES
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"

#############################
### ABBREVIATIONS/ALIASES ###
#############################

# NixOS shortcuts
abbrev nixc="$HOME/.dotfiles/nix/"

abbrev nixupd="$HOME/.scripts/github.com/noahdotpy/.dotfiles/nixos-update"
abbrev nixapply="$HOME/.scripts/github.com/noahdotpy/.dotfiles/nixos-apply"

# NixOS Home Manager shortcuts
abbrev hman="home-manager"
abbrev hmanc="$HOME/.dotfiles/nix/ideapad-s145/users/noah"

# Program shortcuts

function je() {
  j $1 && $EDITOR .  
}
abbrev e="$EDITOR"

abbrev x="clear"

abbrev gs="git status"
abbrev lg="lazygit"

abbrev ls="exa"
abbrev l="exa -ahl"

abbrev code="codium"

abbrev nv="nvim"
abbrev lv="lvim"
abbrev sv="spacevim"
abbrev svim="spacevim"
abbrev emacsc="emacsclient -c -a 'emacs'"
abbrev py="python3"

##########################
### AUTOSTART PROGRAMS ###
##########################

pfetch

eval "$(starship init zsh)"

###############
### PLUGINS ###
###############

[[ -s /etc/profile.d/autojump.zsh ]] && source /etc/profile.d/autojump.zsh

source $HOME/.zsh/plugins/github.com/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/plugins/github.com/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.zsh/plugins/github.com/zsh-users/zsh-history-substring-search/zsh-history-substring-search.zsh

#####################
### MISCELLANEOUS ###
#####################

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.local/bin/:$PATH"
export PATH="$HOME/.local/bin/distrobox-exported/:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


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

# Misc settings
setopt auto_cd

# History settings
export HISTFILE=$HOME/.zsh_history
export SAVEHIST=1000
setopt share_history

# SET ENVIRONMENTAL VARIABLES
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"

#############################
### ABBREVIATIONS/ALIASES ###
#############################

# Container shortcuts
function "-"() {
  NAME="$1"
  # Get all sequential args after $1 to pass to distrobox-enter
  ARGS=$(echo $@ | awk '{for (i=2; i<NF; i++) printf $i " "; if (NF >= 2) print $NF; }')
  distrobox-enter $NAME -- "$ARGS"
}

# Program shortcuts

function ze() {
  pazi_cd $1 && $EDITOR .  
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


###############
### PLUGINS ###
###############

# like neofetch but smaller (startup and literal lines it outputs)
pfetch

# allows something like `z .dot` to go to `~/.dotfiles`
if command -v pazi &>/dev/null; then
  eval "$(pazi init zsh)" # or 'bash'
fi
alias zf='z --pipe="fzf"'
# better command history management (cargo install atuin)
eval "$(atuin init zsh)"
# better prompt (cargo install starship)
eval "$(starship init zsh)"

eval "$(direnv hook zsh)"

# autocomplete (like from fish)
source $HOME/.zsh/plugins/github.com/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh
# syntax highlighting
source $HOME/.zsh/plugins/github.com/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# example: type `git clone https:` and then when you type arrow it will show all history with `git clone https:` at the start
source $HOME/.zsh/plugins/github.com/zsh-users/zsh-history-substring-search/zsh-history-substring-search.zsh

#####################
### MISCELLANEOUS ###
#####################

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.local/bin/:$PATH"
export PATH="$HOME/.local/bin/distrobox-exported/:$PATH"
export PATH="$HOME/.local/share/flatpak/exports/bin:$PATH" # allow something like `org.gimp.GIMP`

# load Angular CLI autocompletion only if available
[[ -s "/usr/local/bin/ng" ]] && source <(ng completion script)

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

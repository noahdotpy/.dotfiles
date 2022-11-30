# !/usr/bin/env bash

BASE_DIR="$HOME/.dotfiles/dots"

function make_link() {
    FILE="$1"
    DIR="$2"
    echo "Making sym-link: $FILE -> $HOME$(echo "$FILE" | awk -F $BASE_DIR '{print $2}')"
    ln -s -f $FILE $DIR
}

for FILE in $BASE_DIR/.config/*; do
    make_link $FILE $HOME/.config/
done

make_link $BASE_DIR/.scripts/github.com/noahdotpy/.dotfiles $HOME/.scripts/github.com/noahdotpy/

make_link $BASE_DIR/.zshrc $HOME

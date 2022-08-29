# !/usr/bin/env bash

if [[ $1 == "--replace-existing" ]]
then
    echo "Replacing existing files..."

    for FILE in .config/*
    do
        echo "Removing ~/$FILE for replacement."
        rm -rf ~/$FILE
    done

    for FILE in .scripts/*
    do
        echo "Removing ~/$FILE for replacement."
        rm -rf ~/$FILE
    done
fi

ln -s -f ~/.dotfiles/.config/* ~/.config/
ln -s -f ~/.dotfiles/.scripts/* ~/.scripts/

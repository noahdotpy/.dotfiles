# !/usr/bin/env bash

DUNST_PAUSED=$(dunstctl is-paused)

if [[ $1 == "toggle" ]]
then
    dunstctl set-paused toggle
fi

if [[ $DUNST_PAUSED == *"true"* ]]
then
    echo ""
else
    echo ""
fi

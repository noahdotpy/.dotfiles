#!/usr/bin/env bash

# Add this script to your wm startup file.

# Terminate already running dunst instances
pkill dunst

# Wait until the processes have been shut down
while pgrep -u $UID -x dunst >/dev/null; do sleep 1; done

# Launch dunst
dunst -c "$HOME/.config/dunst/dunstrc" &


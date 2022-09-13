if [[ "$DESKTOP_SESSION" == *"bspwm"* ]]; then
    ~/.config/bspwm/lock-screen.sh
elif [[ "$DESKTOP_SESSION" == *"i3"* ]]; then
    ~/.config/i3/lock-screen.sh
elif [[ "$DESKTOP_SESSION" == *"leftwm"* ]]; then
    ~/.config/leftwm/lock-screen.sh
fi

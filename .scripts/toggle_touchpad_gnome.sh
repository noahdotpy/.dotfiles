#!/bin/sh

# This shell script is PUBLIC DOMAIN. You may do whatever you want with it.

TOGGLE=$(gsettings get org.gnome.desktop.peripherals.touchpad send-events)
if [[ $TOGGLE == "'disabled'" ]]; then
    gsettings set org.gnome.desktop.peripherals.touchpad send-events 'enabled'
    notify-send -u normal -i mouse --icon=/usr/share/icons/HighContrast/256x256/status/touchpad-disabled.png "Trackpad disabled"
else
    gsettings set org.gnome.desktop.peripherals.touchpad send-events 'disabled'
    notify-send -u normal -i mouse --icon=/usr/share/icons/HighContrast/256x256/devices/input-touchpad.png "Trackpad enabled"
fi

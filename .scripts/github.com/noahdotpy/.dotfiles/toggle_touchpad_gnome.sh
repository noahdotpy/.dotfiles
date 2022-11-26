#!/bin/sh

# This shell script is PUBLIC DOMAIN. You may do whatever you want with it.

LAST=$(gsettings get org.gnome.desktop.peripherals.touchpad send-events)

if [[ $LAST == *"enabled"* ]]; then
  NEW="'disabled'"    
else
  NEW="'enabled'"
fi

gsettings set org.gnome.desktop.peripherals.touchpad send-events $NEW

if [[ $NEW == *"enabled"* ]]; then
  notify-send -u normal -i mouse --icon=/usr/share/icons/HighContrast/256x256/devices/input-touchpad.png "Trackpad enabled"
else
  notify-send -u normal -i mouse --icon=/usr/share/icons/HighContrast/256x256/status/touchpad-disabled.png "Trackpad disabled"
fi


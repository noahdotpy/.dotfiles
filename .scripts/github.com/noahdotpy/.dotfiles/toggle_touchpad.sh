#!/usr/bin/env bash

# toggle synaptic touchpad on/off

# get current state

TOUCHPAD_ID=12

# SYNSTATE=$(synclient -l | grep TouchpadOff | awk '{ print $3 }')
TOUCHPAD_STATE=$(xinput --list-props $TOUCHPAD_ID | grep "Device Enabled" | awk '{ print $4 }')

# change to other state
if [ $TOUCHPAD_STATE = 1 ]; then
    xinput disable $TOUCHPAD_ID
    echo "Touchpad Disabled"
    notify-send "Touchpad Disabled" --urgency low
elif [ $TOUCHPAD_STATE = 0 ]; then
    xinput enable $TOUCHPAD_ID
    echo "Touchpad Enabled"
    notify-send "Touchpad Enabled" --urgency low
else
    echo "Couldn't get touchpad status from xinput"
    exit 1
fi
exit 0

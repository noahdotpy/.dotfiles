#!/bin/sh

getDefaultSink() {
    defaultSink=$(pactl info | awk -F : '/Default Sink:/{print $2}')
    description=$(pactl list sinks | sed -n "/${defaultSink}/,/Description/s/^\s*Description: \(.*\)/\1/p")
    echo "${description}"
}

getDefaultSource() {
    defaultSource=$(pactl info | awk -F : '/Default Source:/{print $2}')
    description=$(pactl list sources | sed -n "/${defaultSource}/,/Description/s/^\s*Description: \(.*\)/\1/p")
    echo "${description}"
}

VOLUME=$(pulsemixer --get-volume)
MUTED=$(pulsemixer --get-mute)
SINK=$(getDefaultSink)
SOURCE=$(getDefaultSource)
STEP_INTERVAL=5

if [[ $1 == "up" ]]; then
  pulsemixer --change-volume +5
elif [[ $1 == "down" ]]; then
  pulsemixer --change-volume -5
elif [[ $1 == "mute" ]]; then
  pulsemixer --toggle-mute
fi

if [[ $MUTED == "1" ]]
then
    echo "X ${VOLUME} ${SINK}"
else
    echo "${VOLUME} ${SINK}"
fi

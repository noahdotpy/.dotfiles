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

if [[ $MUTED == "1" ]]
then
    echo "X ${VOLUME} ${SINK}"
else
    echo "${VOLUME} ${SINK}"
fi


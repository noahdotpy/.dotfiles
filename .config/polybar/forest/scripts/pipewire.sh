#!/usr/bin/env bash

function getDefaultSink() {
    defaultSink=$(pactl info | awk -F : '/Default Sink:/{print $2}')
    description=$(pactl list sinks | sed -n "/${defaultSink}/,/Description/s/^\s*Description: \(.*\)/\1/p")
    echo "${description}"
}

function getDefaultSource() {
    defaultSource=$(pactl info | awk -F : '/Default Source:/{print $2}')
    description=$(pactl list sources | sed -n "/${defaultSource}/,/Description/s/^\s*Description: \(.*\)/\1/p")
    echo "${description}"
}

function outputVolumes() {
    if [ "${IS_MUTED}" == "1" ]; then
            # echo " ${SOURCE} |   MUTED ${SINK}"
            echo "  MUTED ${SINK}"
        else
            # echo " ${SOURCE} |    ${VOLUME}% ${SINK}"
            echo "   ${VOLUME}% ${SINK}"
    fi
}

function main() {
    # Pipewire
    # SOURCE=$(pw-record --channels | sed -n 's/^*.*"\(.*\)" prio=.*$/\1/p')
    # SINK=$(pw-play --channels | sed -n 's/^*.*"\(.*\)" prio=.*$/\1/p')
    SINK=$(getDefaultSink)
    SOURCE=$(getDefaultSource)
    VOLUME=$(pactl list sinks | sed -n "/${SINK}/,/Volume/ s!^[[:space:]]\+Volume:.* \([[:digit:]]\+\)%.*!\1!p")
    IS_MUTED=$(pulsemixer --get-mute)

    action=$1
    step=5
    if [ "${action}" == "up" ]; then
        pactl set-sink-volume @DEFAULT_SINK@ +${step}%
    elif [ "${action}" == "down" ]; then
        pactl set-sink-volume @DEFAULT_SINK@ -${step}%
    elif [ "${action}" == "mute" ]; then
        pulsemixer --toggle-mute
    fi
    outputVolumes
}

main $@

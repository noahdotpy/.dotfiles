#!/usr/bin/env bash

BATTERY_INFO="upower -i /org/freedesktop/UPower/devices/battery_BAT0"

# Formatting helpers

STATE=$( $BATTERY_INFO | grep state | awk '{ print $2 }' )
if [[ "$STATE" == "fully-charged" || "$STATE" == "charging" ]]; then
  STATE="+"
elif [[ "$STATE" == "discharging" ]]; then
  STATE="-"
fi

CHARGE=$( $BATTERY_INFO | grep percentage | awk '{ print $2 }' | awk -F '%' '{ print $1 }' )
FORMAT=""


# Discharging
if [[ $STATE == "-" ]]; then
  if (( $CHARGE <= 20 )); then # *-20
    ICON=""
  elif (( $CHARGE <= 30 )); then # 21-30
    ICON=""
  elif (( $CHARGE <= 40 )); then # 31-40
    ICON=""
  elif (( $CHARGE <= 60 )); then # 41-60
    ICON=""
  elif (( $CHARGE <= 80 )); then # 61-80
    ICON=""
  elif (( $CHARGE <= 95 )); then # 81-95
    ICON=""
  elif (( $CHARGE >= 96 )); then # 96-*
    ICON=""
  fi
fi


# Charging
if [[ $STATE == "+" ]]; then
  if (( $CHARGE <= 20 )); then # *-20
    ICON=""
  elif (( $CHARGE <= 30 )); then # 21-30
    ICON=""
  elif (( $CHARGE <= 40 )); then # 31-40
    ICON=""
  elif (( $CHARGE <= 60 )); then # 41-60
    ICON=""
  elif (( $CHARGE <= 80 )); then # 61-80
    ICON=""
  elif (( $CHARGE <= 95 )); then # 81-95
    ICON=""
  elif (( $CHARGE >= 96 )); then # 96-*
    ICON=""
  fi
fi

# Format CHARGE & color depending on the status.
FORMAT="$FORMAT $ICON $CHARGE"
# Display on bar
echo $FORMAT

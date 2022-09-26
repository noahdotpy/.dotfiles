## battery_detect_acpi.sh 

#!/usr/bin/bash


# Getting the data and initializing an array.
BATTERY_INFO=($( acpi | awk -F',' '{ print $0 }'))

# Formatting helpers

if [[ "${BATTERY_INFO[2]}" == *"Charging"* ]]; then
  STATUS="+"
elif [[ "${BATTERY_INFO[2]}" == *"Discharging"* ]]; then
  STATUS="-"
fi

CHARGE_UNFMT=($( echo ${BATTERY_INFO[3]} | sed 's/,//g' ))
CHARGE=($(echo $CHARGE_UNFMT | awk -F '%' '{ print $1 }'))
FORMAT=""


# Discharging
if [[ $STATUS == "-" ]]; then
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
if [[ $STATUS == "+" ]]; then
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

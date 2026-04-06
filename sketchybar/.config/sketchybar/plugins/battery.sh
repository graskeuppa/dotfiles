#!/bin/bash

HOME= "/Users/gras"
source "$HOME/.config/sketchybar/colors_catppuccinmocha.sh"
source "$HOME/.config/sketchybar/icons.sh"

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

DRAWING=on
COLOR=$TEXT
case "${PERCENTAGE}" in
9[0-9] | 100)
  ICON=$BATTERY_100
  DRAWING=on
  ;;
[6-8][0-9])
  ICON=$BATTERY_75
  DRAWING=on
  ;;
[3-5][0-9])
  ICON=$BATTERY_50
  DRAWING=on
  ;;
[1-2][0-9])
  ICON=$BATTERY_25
  COLOR=$PEACH
  DRAWING=on
  ;;
*)
  ICON=""
  COLOR=$RED
  DRAWING=on
  ;;
esac

if [[ "$CHARGING" != "" ]]; then
  ICON="􀋨"
  DRAWING=on
  COLOR=$TEAL
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set "$NAME" drawing="$DRAWING" icon="$ICON" icon.color="$COLOR"

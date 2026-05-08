#!/bin/bash

HOME="/Users/gras"
source "$HOME/.config/sketchybar/colors_catppuccinmocha.sh"
source "$HOME/.config/sketchybar/icons.sh"

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
BATT_STATUS="$(pmset -g batt)"
CHARGING="$(echo "$BATT_STATUS" | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

DRAWING=on
COLOR=$TEXT

# --- Existing Percentage Logic ---
case "${PERCENTAGE}" in
9[0-9] | 100)
  ICON=$BATTERY_100
  ;;
[6-8][0-9])
  ICON=$BATTERY_75
  ;;
[3-5][0-9])
  ICON=$BATTERY_50
  ;;
2[0-9])
  ICON=$BATTERY_25
  COLOR=$PEACH
  ;;
[0-1][0-9])
  ICON=$BATTERY_25
  COLOR=$RED
  ;;
*)
  ICON=$BATTERY_0
  COLOR=$RED
  ;;
esac

if [[ "$CHARGING" != "" ]]; then
  if echo "$BATT_STATUS" | grep -q "not charging"; then
    ICON=$AC_POWER
    COLOR=$TEAL
  else
    ICON=$BATTERY_CHARGING
    COLOR=$MAUVE
  fi
fi

sketchybar --animate tanh 60 --set "$NAME" drawing="$DRAWING" icon="$ICON" icon.color="$COLOR"

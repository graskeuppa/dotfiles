#!/bin/bash

source "$HOME/.config/sketchybar/icons.sh"
source "$HOME/.config/sketchybar/colors_catppuccinmocha.sh"

case $INFO in
[6-9][0-9] | 100)
  ICON=$VOLUME_100
  COLOR=$TEXT
  ;;
[3-5][0-9])
  ICON=$VOLUME_66
  COLOR=$TEXT
  ;;
[1-2][0-9])
  ICON=$VOLUME_33
  COLOR=$TEXT
  ;;
[1-9])
  ICON=$VOLUME_10
  COLOR=$TEXT
  ;;
0)
  ICON=$VOLUME_0
  COLOR=$SURFACE_2
  ;;
*)
  ICON=$VOLUME_100
  COLOR=$TEXT
  ;;
esac

# Update the item that triggered the script ($NAME)
sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR"

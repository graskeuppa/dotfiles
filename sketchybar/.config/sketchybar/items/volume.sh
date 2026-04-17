#!/bin/bash

volume_icon=(
  script="$PLUGIN_DIR/volume.sh"
  updates=on
  padding_left=10
  padding_right=10
  icon=$VOLUME_100
  icon.color=$SURFACE_2
  icon.font="$FONT:Regular:13.0"
  label.drawing=off
)

status_bracket=(
  background.color=$SURFACE_0
  background.border_color=$SURFACE_1
  background.border_width=2
)

sketchybar --add item volume_icon right \
  --set volume_icon "${volume_icon[@]}" \
  --subscribe volume_icon volume_change

sketchybar --add bracket status brew volume_icon \
  --set status "${status_bracket[@]}"

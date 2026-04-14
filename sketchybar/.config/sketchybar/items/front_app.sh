#!/bin/bash

FRONT_APP_SCRIPT='sketchybar --set $NAME label="$INFO"'

aerospace_mode=(
  script="$PLUGIN_DIR/aerospace_mode.sh"
  icon.font="$FONT:Bold:16.0"
  label.drawing=off
  icon.width=30
  icon="$GRID"
  icon.color=$RED
  associated_display=active
)

front_app=(
  script="$FRONT_APP_SCRIPT"
  icon.drawing=off
  padding_left=0
  label.color=$TEXT
  label.font="$FONT:Bold:12.0"
  associated_display=active
)

sketchybar --add event aerospace_mode_change

sketchybar --add item aerospace left \
  --set aerospace "${aerospace_mode[@]}" \
  --subscribe aerospace aerospace_mode_change front_app_switched space_change \
  \
  --add item front_app left \
  --set front_app "${front_app[@]}" \
  --subscribe front_app front_app_switched

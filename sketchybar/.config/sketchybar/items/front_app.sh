#!/bin/bash

FRONT_APP_SCRIPT='sketchybar --set $NAME label="$INFO"'

# 1. Replace 'yabai' with an 'aerospace' mode indicator
aerospace_mode=(
  script="$PLUGIN_DIR/aerospace_mode.sh"
  icon.font="$FONT:Bold:16.0"
  label.drawing=off
  icon.width=30
  icon="$YABAI_GRID" # Default icon (you can change this!)
  icon.color=$PEACH
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

# 2. Register the custom AeroSpace mode event
sketchybar --add event aerospace_mode_change

# 3. Add the items and subscribe them
sketchybar --add item aerospace left \
  --set aerospace "${aerospace_mode[@]}" \
  --subscribe aerospace aerospace_mode_change front_app_switched space_change \
  \
  --add item front_app left \
  --set front_app "${front_app[@]}" \
  --subscribe front_app front_app_switched

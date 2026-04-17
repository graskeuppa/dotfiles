#!/bin/bash

brew=(
  icon=􀐚
  label=?
  padding_right=10
  update_freq=120
  script="$PLUGIN_DIR/brew.sh"
)

sketchybar --add event brew_update \
  --add item brew right \
  --set brew "${brew[@]}" \
  --subscribe brew brew_update

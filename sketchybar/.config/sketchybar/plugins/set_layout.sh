#!/usr/bin/env bash

# What layout shortcut did you just press?
ACTION=$1

# What workspace are you currently looking at?
WORKSPACE=$(aerospace list-workspaces --focused)

# Save the state specifically for this workspace
if [ "$ACTION" = "toggle_floating" ]; then
  # Flip the floating state on or off
  if [ -f "/tmp/aerospace_floating_$WORKSPACE" ]; then
    rm "/tmp/aerospace_floating_$WORKSPACE"
  else
    touch "/tmp/aerospace_floating_$WORKSPACE"
  fi
else
  # It's either "tiles" or "accordion"
  echo "$ACTION" >"/tmp/aerospace_layout_$WORKSPACE"
fi

# Tell SketchyBar to update!
sketchybar --trigger aerospace_mode_change

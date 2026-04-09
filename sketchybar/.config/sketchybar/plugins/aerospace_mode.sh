#!/usr/bin/env bash

# Ensure SketchyBar has the correct paths to find AeroSpace
export PATH="$PATH:/opt/homebrew/bin:/usr/local/bin"

source "$HOME/.config/sketchybar/colors_catppuccinmocha.sh"
source "$HOME/.config/sketchybar/icons.sh"

# 1. Ask AeroSpace ONLY for the variables it actually supports right now
FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
IS_FULLSCREEN=$(aerospace list-windows --focused --format "%{window-is-fullscreen}" 2>/dev/null)

# 2. Read your custom layout states from the temp files!
LAYOUT_STATE=$(cat "/tmp/aerospace_layout_$FOCUSED_WORKSPACE" 2>/dev/null)

if [ -f "/tmp/aerospace_floating_$FOCUSED_WORKSPACE" ]; then
  IS_FLOATING="true"
else
  IS_FLOATING="false"
fi

# 3. Determine the icon and color based on the state hierarchy
if [ "$IS_FULLSCREEN" = "true" ]; then
  # Fullscreen
  ICON=$FULLSCREEN
  COLOR=$MAUVE
elif [ "$IS_FLOATING" = "true" ]; then
  # Floating
  ICON=$FLOATING
  COLOR=$MAUVE
elif [[ "$LAYOUT_STATE" == *"accordion"* ]]; then
  # Accordion / Stacked
  ICON=$ACCORDION
  COLOR=$LAVENDER
else
  # Default: Tiling (Grid)
  ICON=$GRID
  COLOR=$LAVENDER
fi

# Push the update to your SketchyBar item
sketchybar --set aerospace icon="$ICON" icon.color=$COLOR

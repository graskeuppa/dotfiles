#!/usr/bin/env bash

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
  COLOR=$TEAL
elif [[ "$LAYOUT_STATE" == *"v_accordion"* ]]; then
  # Vertical Accordion
  ICON=$V_ACCORDION
  COLOR=$LAVENDER
elif [[ "$LAYOUT_STATE" == *"h_accordion"* ]]; then
  # Horizontal Accordion
  ICON=$H_ACCORDION
  COLOR=$LAVENDER
elif [[ "$LAYOUT_STATE" == *"v_tiles"* ]]; then
  # Vertical Grid
  ICON=$V_GRID
  COLOR=$LAVENDER
elif [[ "$LAYOUT_STATE" == *"h_tiles"* ]]; then
  # Horizontal Grid
  ICON=$H_GRID
  COLOR=$LAVENDER
elif [[ "$LAYOUT_STATE" == *"accordion"* ]]; then
  # Fallback just in case it only says "accordion"
  ICON=$V_ACCORDION
  COLOR=$PEACH
else
  # Default Fallback
  ICON=$H_GRID
  COLOR=$LAVENDER
fi

# Push the update to your SketchyBar item
sketchybar --animate linear 10 --set aerospace icon="$ICON" icon.color=$COLOR

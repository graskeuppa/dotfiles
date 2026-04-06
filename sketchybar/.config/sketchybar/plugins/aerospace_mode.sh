#!/usr/bin/env bash

source "$HOME/.config/sketchybar/colors_catppuccinmocha.sh"
source "$HOME/.config/sketchybar/icons.sh"
# 1. Check if the focused window is fullscreen in AeroSpace
AERO_FULLSCREEN=$(aerospace list-windows --focused --format "%{window-is-fullscreen}" 2>/dev/null)

# 2. Logic to determine the state and assign icons/colors
if [ "$AERO_FULLSCREEN" = "true" ]; then
  # Fullscreen State
  ICON=$ZOOM   # Fullscreen icon
  COLOR=$GREEN # Red (Change to your preferred hex)
else
  # Normal / Tiling State
  ICON=$GRID    # Grid icon
  COLOR=$MAROON # Peach (Change to your preferred hex)
fi

# 3. Push the update to your SketchyBar item
sketchybar --set aerospace icon="$ICON" icon.color=$COLOR

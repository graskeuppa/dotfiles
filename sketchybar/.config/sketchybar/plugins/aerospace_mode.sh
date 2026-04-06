#!/usr/bin/env bash

source "$HOME/.config/sketchybar/colors_catppuccinmocha.sh"
source "$HOME/.config/sketchybar/icons.sh"
# 1. Check if the focused window is fullscreen in AeroSpace
FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
AERO_FULLSCREEN=$(aerospace list-windows --focused --format "%{window-is-fullscreen}" 2>/dev/null)
LAYOUT_STATE=$(cat "/tmp/aerospace_layout_$FOCUSED_WORKSPACE" 2>/dev/null)

# 2. Logic to determine the state and assign icons/colors
if [ "$AERO_FULLSCREEN" = "true" ]; then
  # Fullscreen State
  ICON=$FULLSCREEN # Fullscreen icon
  COLOR=$MAUVE     # Red (Change to your preferred hex)
else
  # Normal / Tiling State
  ICON=$GRID   # Grid icon
  COLOR=$MAUVE # Peach (Change to your preferred hex)
fi

# Check if the floating toggle file exists
if [ -f "/tmp/aerospace_floating_$FOCUSED_WORKSPACE" ]; then
  IS_FLOATING="true"
else
  IS_FLOATING="false"
fi

# 2. Determine the icon and color based on the state hierarchy
if [ "$AERO_FULLSCREEN" = "true" ]; then
  # Fullscreen
  ICON=$FULLSCREEN
  COLOR=$MAUVE
elif [ "$IS_FLOATING" = "true" ]; then
  # Floating
  ICON=$FLOATING
  COLOR=$TEAL
elif [ "$LAYOUT_STATE" = "accordion" ]; then
  # Accordion / Stacked
  ICON=$ACCORDION
  COLOR=$SKY
else
  # Default: Tiling (Grid)
  ICON=$GRID
  COLOR=$SAPPHIRE
fi

# 3. Push the update to your SketchyBar item
sketchybar --set aerospace icon="$ICON" icon.color=$COLOR

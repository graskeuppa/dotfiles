#!/usr/bin/env bash

source "$HOME/.config/sketchybar/colors.sh"

# 1. Load the exact same Homebrew environment your terminal uses!
if [ -x "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x "/usr/local/bin/brew" ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# 2. Prevent brew from getting stuck doing background updates
export HOMEBREW_NO_AUTO_UPDATE=1

# 3. Count the outdated packages
COUNT=$(brew outdated | wc -l | awk '{print $1}')

COLOR=$RED
ICON=""

case "$COUNT" in
[3-5][0-9])
  COLOR=$PEACH
  ;;
[1-2][0-9])
  COLOR=$YELLOW
  ;;
[1-9])
  COLOR=$TEXT
  ;;
0)
  COLOR=$GREEN
  COUNT="✓"
  ;;
*)
  # Catch-all
  COLOR=$RED
  ;;
esac

sketchybar --set $NAME label="$COUNT" icon="$ICON" icon.color=$COLOR

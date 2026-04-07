#!/usr/bin/env bash

source "$HOME/.config/sketchybar/colors.sh"

update_brew() {
  # 1. Brute-force the paths so Homebrew cannot fail to find its files
  export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
  export HOMEBREW_NO_AUTO_UPDATE=1

  # 2. Count directly! This avoids the "echo" bug that caused your '1'
  # COUNT=$(brew outdated 2>/dev/null | wc -l | tr -d ' ')
  COUNT=$(brew outdated | wc -l | tr -d ' ')
  COLOR=$RED

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

  # 3. Send the final data to SketchyBar (hardcoding 'brew' as the item name)
  sketchybar --set brew label="$COUNT" icon.color=$COLOR
}

# Run the function in the background
update_brew &

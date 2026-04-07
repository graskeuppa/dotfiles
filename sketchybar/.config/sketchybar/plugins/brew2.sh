#!/bin/bash

# 1. LOG EVERYTHING to a file so we can monitor it
exec >/tmp/sketchybar_brew.log 2>&1

echo "----------------------------------------"
echo "[$(date)] Starting brew script..."

source "$HOME/.config/sketchybar/colors_catppuccinmocha.sh"

update_brew() {
  echo "Setting up paths..."
  export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
  export HOMEBREW_NO_AUTO_UPDATE=1

  echo "Running brew outdated..."

  # 2. MAC OS TAHOE BUG FIX: Force a new ZSH session so Ruby doesn't crash!
  RAW_OUTPUT=$(/bin/zsh -c "brew outdated 2>&1")
  echo "Homebrew raw output:"
  echo "$RAW_OUTPUT"
  echo "-----------------"

  COUNT=$(/bin/zsh -c "brew outdated 2>/dev/null | wc -l | tr -d ' '")
  echo "Final count calculated: $COUNT"

  COLOR=$RED

  case "$COUNT" in
  [3-5][0-9]) COLOR=$ORANGE ;;
  [1-2][0-9]) COLOR=$YELLOW ;;
  [1-9]) COLOR=$WHITE ;;
  0)
    COLOR=$GREEN
    COUNT="􃇽"
    ;;
  esac

  echo "Pushing update to SketchyBar... (Label: $COUNT)"
  sketchybar --set brew label="$COUNT" icon.color="$COLOR"
  echo "[$(date)] Done!"
}

# Run in background
update_brew &

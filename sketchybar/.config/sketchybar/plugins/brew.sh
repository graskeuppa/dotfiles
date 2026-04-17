#!/bin/bash

# 1. LOG EVERYTHING to a file so we can monitor it
exec >/tmp/sketchybar_brew.log 2>&1

source "$HOME/.config/sketchybar/colors_catppuccinmocha.sh"

update_brew() {
  export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
  export HOMEBREW_NO_AUTO_UPDATE=1

  # 2. MAC OS TAHOE BUG FIX: Force a new ZSH session so Ruby doesn't crash!
  RAW_OUTPUT=$(/bin/zsh -c "brew outdated 2>&1")

  COUNT=$(/bin/zsh -c "brew outdated 2>/dev/null | wc -l | tr -d ' '")

  COLOR=$RED

  case "$COUNT" in
  [3-5][0-9]) COLOR=$PEACH ;;
  [1-2][0-9]) COLOR=$YELLOW ;;
  [1-9]) COLOR=$TEXT ;;
  0)
    COLOR=$TEAL
    COUNT="􃇽"
    ;;
  esac

  sketchybar --set brew label="$COUNT" icon.color="$COLOR"
}

# Run in background
update_brew &

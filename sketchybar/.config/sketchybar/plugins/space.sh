#!/usr/bin/env bash

# $1 is the workspace ID passed from your sketchybarrc loop (e.g. script=".../space.sh $sid")
SID="$1"

update() {
  # If SketchyBar starts up and FOCUSED_WORKSPACE is empty, fetch it manually
  if [ -z "$FOCUSED_WORKSPACE" ]; then
    FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
  fi

  # Compare this item's ID with the currently focused workspace
  if [ "$SID" = "$FOCUSED_WORKSPACE" ]; then
    SELECTED="true"
    WIDTH="dynamic" # Change this to 0 to hide the app icon when on a selected workspace
  else
    SELECTED="false"
    WIDTH="dynamic"
  fi

  sketchybar --animate linear 10 --set "$NAME" icon.highlight="$SELECTED" label.width="$WIDTH" label.highlight="$SELECTED"
}

mouse_clicked() {
  if [ "$BUTTON" = "right" ]; then
    # AeroSpace doesn't "destroy" spaces like Yabai.
    # Instead, right-clicking the pill will instantly throw your active window to that space!
    aerospace move-node-to-workspace "$SID"
  else
    # Left-click to focus the workspace natively
    aerospace workspace "$SID"
  fi
}

case "$SENDER" in
"mouse.clicked")
  mouse_clicked
  ;;
*)
  update
  ;;
esac

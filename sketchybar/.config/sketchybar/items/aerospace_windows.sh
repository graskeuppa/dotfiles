#!/usr/bin/env bash

# This creates the invisible item that listens for changes and runs your plugin script
sketchybar --add item aerospace_windows left \
  --set aerospace_windows script="$PLUGIN_DIR/aerospace_windows.sh" \
  drawing=off \
  --subscribe aerospace_windows front_app_switched aerospace_workspace_change space_windows_change

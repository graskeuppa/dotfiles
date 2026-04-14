#!/bin/bash

sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --all); do
  space=(
    icon="$sid"
    icon.y_offset=1
    icon.padding_left=10
    icon.padding_right=15
    padding_left=2
    padding_right=2
    label.padding_right=10
    icon.highlight_color=$BLUE
    label.font="sketchybar-app-font:Regular:14.0"
    # label.font="$FONT:Regular:9.0", use this for debugging the sketchybar-app-font
    label.background.height=26
    label.background.drawing=on
    label.background.color=$SURFACE_1
    label.background.corner_radius=8
    label.drawing=off
    label.y_offset=-1
    label.color=$TEXT
    script="$PLUGIN_DIR/space.sh $sid"
    click_script="aerospace workspace $sid"
  )

  sketchybar --add item space.$sid left \
    --subscribe space.$sid aerospace_workspace_change mouse.clicked \
    --set space.$sid "${space[@]}"
done

bracket_props=(
  background.color=$SURFACE_0
  background.border_color=$SURFACE_1
  background.border_width=2
  background.drawing=on
)

separator=(
  icon=􀆓
  icon.font="$FONT:Bold:14.0"
  padding_left=15
  padding_right=15
  label.drawing=off
  associated_display=active
  icon.color=$TEXT
)

sketchybar --add bracket spaces '/space\..*/' \
  --set spaces "${bracket_props[@]}" \
  \
  --add item separator left \
  --set separator "${separator[@]}"

sketchybar --add item aerospace_windows left \
  --set aerospace_windows script="$PLUGIN_DIR/aerospace_windows.sh" \
  icon.drawing=off \
  label.drawing=off \
  width=0 \
  update_freq=1 \
  --subscribe aerospace_windows front_app_switched aerospace_workspace_change space_windows_change

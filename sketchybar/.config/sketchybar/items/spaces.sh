#!/bin/bash

# 1. Define the custom AeroSpace event FIRST
sketchybar --add event aerospace_workspace_change

# 2. Ask AeroSpace for all current workspaces
for sid in $(aerospace list-workspaces --all); do
  space=(
    icon="$sid" # Use the AeroSpace workspace name as the icon
    icon.y_offset=1
    icon.padding_left=10
    icon.padding_right=15
    padding_left=2
    padding_right=2
    # label.padding_left=10
    label.padding_right=10
    icon.highlight_color=$BLUE
    label.font="sketchybar-app-font:Regular:14.0"
    # label.font="$FONT:Regular:9.0"
    label.background.height=26
    label.background.drawing=on
    label.background.color=$SURFACE_1
    label.background.corner_radius=8
    label.drawing=off
    label.y_offset=-1
    label.color=$TEXT
    # Pass the $sid to the script so it knows which workspace it's updating
    script="$PLUGIN_DIR/space.sh $sid"
    # Switch AeroSpace workspace when clicked!
    click_script="aerospace workspace $sid"
  )

  # 3. Use 'item' instead of 'space', and subscribe to AeroSpace events
  sketchybar --add item space.$sid left \
    --subscribe space.$sid aerospace_workspace_change mouse.clicked \
    --set space.$sid "${space[@]}"
done

# 4. Define bracket and separator properties
bracket_props=(
  background.color=$SURFACE_0
  background.border_color=$SURFACE_1
  background.border_width=2
  background.drawing=on
)

separator=(
  icon=􀆊
  icon.font="$FONT:Heavy:16.0"
  padding_left=15
  padding_right=15
  label.drawing=off
  associated_display=active
  icon.color=$TEXT
)

# 5. Draw the bracket and separator
sketchybar --add bracket spaces '/space\..*/' \
  --set spaces "${bracket_props[@]}" \
  \
  --add item separator left \
  --set separator "${separator[@]}"

# # 6. ADD THE INVISIBLE LISTENER HERE to trigger your app icons!
# sketchybar --add item aerospace_windows left \
#   --set aerospace_windows script="$PLUGIN_DIR/aerospace_windows.sh" \
#   drawing=off \
#   update_freq=1 \
#   --subscribe aerospace_windows front_app_switched aerospace_workspace_change space_windows_change
# # 6. ADD THE INVISIBLE LISTENER HERE to trigger your app icons!
sketchybar --add item aerospace_windows left \
  --set aerospace_windows script="$PLUGIN_DIR/aerospace_windows.sh" \
  icon.drawing=off \
  label.drawing=off \
  width=0 \
  update_freq=1 \
  --subscribe aerospace_windows front_app_switched aerospace_workspace_change space_windows_change

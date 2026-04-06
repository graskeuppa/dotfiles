#!/usr/bin/env bash
export PATH="$PATH:/opt/homebrew/bin:/usr/local/bin"

# 1. Source the newly downloaded icon map file
source "$HOME/.config/sketchybar/plugins/icon_map.sh"

update_windows_on_spaces() {
  args=()
  WORKSPACES=$(aerospace list-workspaces --all)

  ALL_WINDOWS=$(aerospace list-windows --all --format '%{workspace}|%{app-name}')

  for space in $WORKSPACES; do
    icon_strip=""

    apps=$(echo "$ALL_WINDOWS" | grep "^$space|" | cut -d'|' -f2-)

    if [ -n "$apps" ]; then
      while IFS= read -r app; do
        app=$(echo "$app" | xargs)

        if [ -n "$app" ]; then
          # 2. Call the function directly and read the resulting variable
          __icon_map "$app"
          icon="$icon_result"
          icon_strip+=" $icon"
        fi
      done <<<"$apps"

      # There ARE apps, so draw the label and background!
      args+=(--set space.$space label="$icon_strip" label.drawing=on)
    else
      # NO apps, so completely hide the label and background!
      args+=(--set space.$space label="" label.drawing=off)

    fi

  done

  if [ ${#args[@]} -gt 0 ]; then
    sketchybar "${args[@]}"
  fi
}

update_windows_on_spaces

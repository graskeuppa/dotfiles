#!/usr/bin/env bash
export PATH="$PATH:/opt/homebrew/bin:/usr/local/bin"

# 1. Source the newly downloaded icon map file
source "$HOME/.config/sketchybar/plugins/icon_map.sh"

update_windows_on_spaces() {
  args=()
  WORKSPACES=$(aerospace list-workspaces --all)

  ALL_WINDOWS=$(aerospace list-windows --all --format '%{workspace}|%{app-name}|%{window-title}')

  for space in $WORKSPACES; do
    icon_strip=""

    apps=$(echo "$ALL_WINDOWS" | grep "^$space|" | cut -d'|' -f2-)

    if [ -n "$apps" ]; then
      while IFS='|' read -r app title; do
        app=$(echo "$app" | xargs)
        title=$(echo "$title" | xargs)

        if [ -n "$app" ]; then

          # --------------------------------------------------------
          # THE TERMINAL APP OVERRIDES
          # --------------------------------------------------------
          if [ "$app" = "Ghostty" ]; then
            # Order matters! The first match wins.
            case "$title" in
            # 1. Check Yazi first. This catches "yazi: ~/.config/nvim" before the nvim rule can get confused by it.
            [Yy]azi* | *yazi*) icon=":yazi:" ;;

            # 2. Now it is safe to use wildcards for Neovim, catching titles like "filename.txt - NVIM"
            *[Nn]vim* | *[Vv]im* | n | n\ *) icon=":neovim:" ;;
            *)
              # If it's none of the above, just show the normal Ghostty icon
              __icon_map "$app"
              icon="$icon_result"
              ;;
            esac
          else
            # For all normal Mac apps (Safari, Discord, etc), use the map
            __icon_map "$app"
            icon="$icon_result"
          fi
          # --------------------------------------------------------

          icon_strip+=" $icon"
        fi
      done <<<"$apps"

      args+=(--set space.$space label="$icon_strip" label.drawing=on)
    else
      args+=(--set space.$space label="" label.drawing=off)
    fi

  done

  if [ ${#args[@]} -gt 0 ]; then
    sketchybar "${args[@]}"
  fi
}

update_windows_on_spaces

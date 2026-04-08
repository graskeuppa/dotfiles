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
            # We only check what the title STARTS WITH to avoid folder name mix-ups!
            case "$title" in
            nvim* | n*) icon=":neovim:" ;;       # Neovim
            yazi* | y* | Yazi*) icon=":yazi:" ;; # Yazi (Folder icon)
            *)
              # If it's none of the above, just show the Ghostty icon
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

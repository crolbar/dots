{pkgs, ...}: {
  xdg.configFile."niri/eww/scripts/workspace_scroll.sh".source = pkgs.writers.writeBash "workspace_scroll.sh" ''
    if [[ "$1" == "up" ]]; then
        niri msg action focus-workspace "$(niri msg -j workspaces | jq '[.[] | select(.active_window_id != null or .is_active == true)] | sort_by(.id)' | jq -r '. as $arr | to_entries[] | select(.value.is_focused == true) | $arr[if .key == 0 then 0 else .key-1 end'].idx)"
    elif [[ "$1" == "down" ]]; then
        niri msg action focus-workspace "$(niri msg -j workspaces | jq '[.[] | select(.active_window_id != null or .is_active == true)] | sort_by(.id)' | jq -r '. as $arr | to_entries[] | select(.value.is_focused == true) | $arr[.key+1'].idx)"
    fi
  '';
}

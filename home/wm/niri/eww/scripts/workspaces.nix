{pkgs, ...}: {
  xdg.configFile."niri/eww/scripts/workspaces.sh".source = pkgs.writers.writeBash "workspaces" ''
    up() {
        niri msg -j workspaces | jq '[.[] | select(.active_window_id != null or .is_active == true)] | sort_by(.id)' -c
    }

    niri msg -j event-stream | while read -r l; do up "$l"; done
  '';
}

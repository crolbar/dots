{pkgs, ...}: {
  xdg.configFile."niri/eww/scripts/niri".source = pkgs.writers.writeBash "niri" ''
    up() {
        workspaces=$(niri msg -j workspaces | jq '[.[] | select(.active_window_id != null or .is_active == true)] | sort_by(.id)' -c)

        currwin=$(niri msg -j focused-window | jq -r ".title")
        kb_layout=$(niri msg -j keyboard-layouts | jq -r ".names[.current_idx]")

        currwin=''${currwin//\"/\\\"}

        echo "{\"workspaces\": $workspaces, \"currwin\": \"$currwin\", \"kb_layout\": \"$kb_layout\"}"
    }
    up

    niri msg -j event-stream | while read -r l; do up "$l"; done
  '';
}

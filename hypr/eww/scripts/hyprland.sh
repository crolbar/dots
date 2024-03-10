#!/bin/bash
print() {
    workspaces=$(hyprctl workspaces -j | jq -c 'sort_by(.id)')
    active=$(hyprctl activeworkspace -j | jq '.id')
    currwin=$(hyprctl activewindow -j | jq -r '.title' | cut -c1-90)
    kb_layout=$(hyprctl devices -j | jq '.keyboards[] | select(.name == "sino-wealth-bluetooth-keyboard") | .active_keymap')

    echo "{\"workspaces\": $workspaces, \"active\": $active, \"currwin\": \"$currwin\", \"kb_layout\": $kb_layout}"
}
print

nc -U /tmp/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock | while read -r _; do print; done

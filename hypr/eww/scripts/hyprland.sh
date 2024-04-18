#!/bin/bash
print() {
    workspaces=$(hyprctl workspaces -j | jq -c 'sort_by(.id)')
    active=$(hyprctl activeworkspace -j | jq '.id')
    currwin=$(hyprctl activewindow -j | jq -r '.title')
    kb_layout=$(hyprctl devices -j | jq '.keyboards[] | select(.name == "sino-wealth-bluetooth-keyboard") | .active_keymap')

    echo "{\"workspaces\": $workspaces, \"active\": $active, \"currwin\": \"$currwin\", \"kb_layout\": $kb_layout}"
}
print

socat -U - UNIX-CONNECT:/tmp/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock | while read -r l; do print "$l"; done

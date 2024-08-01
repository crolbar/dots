#!/usr/bin/env bash
print() {
    case $1 in
        activewindow\>*)        
            workspaces=$(hyprctl workspaces -j | jq -c 'sort_by(.id)')
            active=$(hyprctl activeworkspace -j | jq '.id')
            currwin=$(hyprctl activewindow -j | jq -r '.title')
            kb_layout=$(hyprctl devices -j | jq '.keyboards[] | select(.name == "sino-wealth-bluetooth-keyboard") | .active_keymap')
            
            if [ -z "$kb_layout" ]; then
                kb_layout=$(hyprctl devices -j | jq '.keyboards[] | select(.name == "crolbar-yuki") | .active_keymap')
            fi

            if [ -z "$kb_layout" ]; then
                kb_layout="\"\""
            fi

            if echo "$currwin" | grep '\"'; then
                #currwin=$(echo "$currwin" | sed 's/"/\\"/g')
                currwin=${currwin//\"/\\\"}
            fi

            echo "{\"workspaces\": $workspaces, \"active\": $active, \"currwin\": \"$currwin\", \"kb_layout\": $kb_layout}"
        ;;
    esac
}
print

socat -U - UNIX-CONNECT:"$XDG_RUNTIME_DIR"/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock | while read -r l; do print "$l"; done

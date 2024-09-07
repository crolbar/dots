{pkgs, ...} @ args: {
  xdg.configFile."hypr/eww/scripts/hyprland.sh".source = pkgs.writers.writeBash "hyprland.sh" ''
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

                currwin=''${currwin//\"/\\\"}

                echo "{\"workspaces\": $workspaces, \"active\": $active, \"currwin\": \"$currwin\", \"kb_layout\": $kb_layout}"
            ;;
        esac
    }
    print

    socat -U - UNIX-CONNECT:"$XDG_RUNTIME_DIR"/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock | while read -r l; do print "$l"; done
  '';
}

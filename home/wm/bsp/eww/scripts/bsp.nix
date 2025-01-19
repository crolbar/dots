{
  pkgs,
  ...
}: {
  xdg.configFile."bspwm/eww/scripts/bsp.sh".source = pkgs.writers.writeBash "bsp.sh" ''
    print() {
        workspaces=$(bspc query -D --names | jq -R -s -c 'split("\n")[:-1]')
        active=$(bspc query -D -d focused --names)
        currwin=$(bspc query -n focused -T | jq '.client | .className' | sed -r 's/"//g')

        echo "{\"workspaces\": $workspaces, \"active\": $active, \"currwin\": \"$currwin\"}"
    }

    print

    bspc subscribe | while read -r _; do
        print
    done
  '';
}

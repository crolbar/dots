{pkgs, ...} @ args: {
  xdg.configFile."hypr/scripts/dispatch.sh".source = pkgs.writers.writeBash "dispatch.sh" ''
    activemonitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')
    monitor_output=$(hyprctl monitors | awk '/Monitor/ {print $2}')

    counter=1
    for monitor in $monitor_output; do
      if (( counter == 1 )); then
        prefix="main"
      elif ((counter == 2)); then
        prefix="second"
      else
        prefix="third"
      fi

      declare "$prefix=$monitor"
      (( counter++ ))
    done

    case $2 in
      f)
        case $activemonitor in
        $main)
          hyprctl dispatch workspace "$1";;
        $second)
          hyprctl dispatch workspace $(($1 + 10));;
        $third)
          hyprctl dispatch workspace $(($1 + 20));;
        esac;;
      s)
        case $activemonitor in
        $main)
          hyprctl dispatch movetoworkspacesilent "$1";;
        $second)
          hyprctl dispatch movetoworkspacesilent $(($1 + 10));;
        $third)
          hyprctl dispatch movetoworkspacesilent $(($1 + 20));;
        esac;;
    esac
  '';
}

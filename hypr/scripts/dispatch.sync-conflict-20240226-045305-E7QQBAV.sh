#! /bin/bash
#crolbar
activemonitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')
monitor_output=$(hyprctl monitors | awk '/Monitor/ {print $2}')

# label the monitors to main, second and third

counter=1
for monitor in $monitor_output; do
  if (( counter == 1 )); then
    prefix="third"
  elif ((counter == 2)); then
    prefix="main"
  else
    prefix="second"
  fi
  
  declare "$prefix=$monitor"
  (( counter++ ))
done

case $2 in 
  f)
  # focus to a workspace depending on the focused monitor
    case $activemonitor in 
    $main)
      hyprctl dispatch workspace "$1";;
    $second)
      hyprctl dispatch workspace $(($1 + 10));;
    $third)
      hyprctl dispatch workspace $(($1 + 20));;
    esac;;
  s)
  # move a focused window to the selected workspace on the focused monitor
    case $activemonitor in 
    $main)
      hyprctl dispatch movetoworkspacesilent "$1";;
    $second)
      hyprctl dispatch movetoworkspacesilent $(($1 + 10));;
    $third)
      hyprctl dispatch movetoworkspacesilent $(($1 + 20));;
    esac;;
esac

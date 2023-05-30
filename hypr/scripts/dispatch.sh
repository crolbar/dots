#! /bin/bash
activemonitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')
monitor_output=$(hyprctl monitors | awk '/Monitor/ {print $2}')

declare -a monitor_names
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
  monitor_names+=("$prefix")
  (( counter++ ))
done

case $2 in 
f)
if [ $activemonitor == $main ]; then
  hyprctl dispatch workspace "$1"
elif [ $activemonitor == $second ]; then
  hyprctl dispatch workspace $(($1 + 5))
elif [ $activemonitor == $third ]; then
  hyprctl dispatch workspace $(($1 + 10))
fi;;
s)
if [ $activemonitor == $main ]; then
  hyprctl dispatch movetoworkspacesilent "$1"
elif [ $activemonitor == $second ]; then
  hyprctl dispatch movetoworkspacesilent $(($1 + 5))
elif [ $activemonitor == $third ]; then
  hyprctl dispatch movetoworkspacesilent $(($1 + 10))
fi;;
esac


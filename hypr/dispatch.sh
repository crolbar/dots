#! /bin/bash
activemonitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused == false).name')
monitor_output=$(hyprctl monitors | grep Monitor | awk '{print $2}')
declare -a monitor_names
counter=1
while IFS= read -r monitor; do
  if (( counter == 1 )); then
    prefix="second"
  else
    prefix="main"
  fi
  if (( counter > 2 )); then
    prefix="${counter}_$prefix"
  fi
  variable_name="${prefix}"
  declare "$variable_name=$monitor"
  monitor_names+=("$variable_name")
  (( counter++ ))
done <<< "$monitor_output"

if [ $activemonitor == $main ]; then
hyprctl dispatch workspace "$1"
elif [ $activemonitor == $second ]; then
    if [ $1 -eq 1 ]; then
    hyprctl dispatch workspace 6
    elif [ $1 -eq 2 ]; then 
    hyprctl dispatch workspace 7
    elif [ $1 -eq 3 ]; then
    hyprctl dispatch workspace 8
    elif [ $1 -eq 4 ]; then 
    hyprctl dispatch workspace 9
    elif [ $1 -eq 5 ]; then
    hyprctl dispatch workspace 10
    fi
fi

case $1 in
  s[1-5]) 
if [ $1 == s1 ] && [ $activemonitor == $main ]; then 
  hyprctl dispatch movetoworkspace 1
elif [ $1 == s2 ] && [ $activemonitor == $main ]; then
  hyprctl dispatch movetoworkspace 2
elif [ $1 == s3 ] && [ $activemonitor == $main ]; then
  hyprctl dispatch movetoworkspace 3
elif [ $1 == s4 ] && [ $activemonitor == $main ]; then
  hyprctl dispatch movetoworkspace 4
elif [ $1 == s5 ] && [ $activemonitor == $main ]; then
  hyprctl dispatch movetoworkspace 5
elif [ $1 == s1 ] && [ $activemonitor == $second ]; then
  hyprctl dispatch movetoworkspace 6
elif [ $1 == s2 ] && [ $activemonitor == $second ]; then
  hyprctl dispatch movetoworkspace 7
elif [ $1 == s3 ] && [ $activemonitor == $second ]; then
  hyprctl dispatch movetoworkspace 8
elif [ $1 == s4 ] && [ $activemonitor == $second ]; then
  hyprctl dispatch movetoworkspace 9
elif [ $1 == s5 ] && [ $activemonitor == $second ]; then
  hyprctl dispatch movetoworkspace 10
fi;;
esac

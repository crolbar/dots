#! /bin/sh

case $1 in 
    bar)
    if pgrep -x "eww" >/dev/null; then
        pkill -x "eww"
    else
        eww daemon -c ~/.config/leftwm/themes/right/eww-bar &
        eww open bar0 -c ~/.config/leftwm/themes/right/eww-bar &
    fi;;
esac

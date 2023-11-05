#!/bin/sh

case $1 in 
    bar)
    if pgrep "eww"; then
        pkill eww
    else
        eww daemon -c ~/.config/leftwm/right/eww-bar &
        eww open bar0 -c ~/.config/leftwm/right/eww-bar &
    fi;;
esac

#!/bin/sh
case $1 in 
    tray)
    if pgrep "polybar"; then
        pkill polybar
    else
        polybar tray -c ~/.config/leftwm/right/config.ini &
    fi;;
esac

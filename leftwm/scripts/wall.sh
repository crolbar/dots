#!/bin/sh
wall=$(cat /tmp/.wall)
wallc=$(ls ~/.config/leftwm/right/walls | wc -l)
case $1 in 
    c)
        ((wall $2= 1))
        if [ "$wall" -ge "$wallc" ]; then
            echo 0 > /tmp/.wall
            wall=0
        elif [ "$wall" -le "-1" ]; then 
            ((wallc -= 1))
            echo $wallc > /tmp/.wall
            wall=$wallc
        else
            echo $wall > /tmp/.wall
        fi
        pkill feh
        feh --bg-max ~/.config/leftwm/right/walls/wall$wall.png &;;
    i)
        feh --bg-fill ~/.config/leftwm/right/walls/wall$wall.png &;;
esac

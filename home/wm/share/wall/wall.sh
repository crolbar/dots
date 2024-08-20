#!/usr/bin/env bash
mapfile -t out < <(ls ~/wallpapers ~/wallpapers/nixwalls)
walls=()
for i in "${out[@]}"; do
    if [[ "$i" != */* && "$i" != "nixwalls" && "$i" != "" && "$i" != "state" ]]; then
        walls+=("$i")
    fi
done
# $1 == "b" is backwards
# $1 == "i" is init (set to the last used, aka in state)

wall=""
if [[ $1 != "i" ]]; then
    if [ -f ~/wallpapers/state ]; then
        next_wall_index=0
        curr_wall=$(cat ~/wallpapers/state)
        curr_wall_index=0

        for i in "${!walls[@]}"; do
            if [[ "${walls[$i]}" == "$curr_wall" ]]; then
                curr_wall_index=$i
                break
            fi
        done

        if [[ "$1" != "b" ]]; then
            if [ $((${#walls[@]} - 1)) != "$curr_wall_index" ]; then
                next_wall_index=$((curr_wall_index + 1))
            fi
        else
            if [ "$curr_wall_index" == 0 ]; then
                next_wall_index=$((${#walls[@]} - 1))
            else
                next_wall_index=$((curr_wall_index - 1))
            fi
        fi

        wall=${walls[$next_wall_index]}
        echo "$wall" > ~/wallpapers/state
    else
        wall=${walls[0]}
        echo "$wall" > ~/wallpapers/state
    fi
else
    wall=$(cat ~/wallpapers/state)
fi

if [ -f ~/wallpapers/nixwalls/"$wall" ]; then
    wall="nixwalls/$wall"
fi

wall="$HOME/wallpapers/$wall"

if [ -z "$WAYLAND_DISPLAY" ]; then
    feh --bg-max "$wall" &
else 
    if [ "$1" == "b" ]; then
        swww img "$wall" --transition-type right --transition-fps 60 --transition-bezier 0.5,0.5,0.5,0.5 --transition-duration 0.1 
    else
        swww img "$wall" --transition-type left --transition-fps 60 --transition-bezier 0.5,0.5,0.5,0.5 --transition-duration 0.1
    fi
fi

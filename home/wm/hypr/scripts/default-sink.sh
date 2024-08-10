#!/usr/bin/env bash
# change the default output device to the other avalable
mapfile -t sinks < <(pactl list short sinks | awk '{print $2}')

current_sink=$(pactl get-default-sink)

other_sink=""
for sink in "${sinks[@]}"; do
    if [ "$sink" != "$current_sink" ]; then
        other_sink="$sink"
        break
    fi
done

pactl set-default-sink "$other_sink"
dunstify "Switched to $other_sink"

#!/bin/bash
# changes the default output device
other_sink=$(pacmd list-sinks | awk -v current="$current_sink" '/index:/{i=$0} /index:/{if ($0!=current && !/\* /) { sub(/^index: /, ""); print $2 }}')
    pacmd set-default-sink "$other_sink"

#!/bin/bash
# changes the default output device to the other avalable output device
other_sink=$(pacmd list-sinks | awk '/index:/{i=$0} /index:/{if (!/\* /) { sub(/^index: /, ""); print $2; exit }}')
    pacmd set-default-sink "$other_sink"

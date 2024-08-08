#!/usr/bin/env bash
# changes the default output device to the other avalable

mon="alsa_output.pci-0000_0d_00.1.hdmi-stereo"
head="alsa_output.usb-Logitech_G533_Gaming_Headset-00.iec958-stereo"
if [[ "$(pactl list short sinks | grep RUNNING | cut -f2)" == "$head" ]];then
    pactl set-default-sink $mon
else
    pactl set-default-sink $head
fi

#!/bin/sh
layout=$(setxkbmap -query | grep variant | sed 's/variant:    //')

if [ -z "$layout" ]; then
    setxkbmap us dvorak
elif [ "$layout" = "dvorak" ]; then
    setxkbmap bg phonetic
else
    setxkbmap us
fi

#!/usr/bin/env bash

# define app names (from the output of "pactl list sink-inputs")
music_application_name="spotify"
browser_application_name="Firefox"

set_indexes() {
    pactl_json_sink_inputs=$(pactl --format=json list sink-inputs)
    # grab indexes
    music_index=$(echo $pactl_json_sink_inputs | jq "first(.[]| select(.properties.\"application.name\" == \"$music_application_name\"))| .index")
    browser_indexes=$(echo $pactl_json_sink_inputs | jq ".[]| select(.properties.\"application.name\" == \"$browser_application_name\")| .index")
    mon_index=$(pamixer --list-sinks | grep alsa_output.pci | awk '{print $1}')
    head_index=$(pamixer --list-sinks | grep G533 | awk '{print $1}')

    # state file for browser/music (muted/unmuted)
    is_browser_muted=$(echo $pactl_json_sink_inputs | jq "first(.[]| select(.properties.\"application.name\" == \"$browser_application_name\"))| .mute")
    is_music_muted=$(echo $pactl_json_sink_inputs | jq "first(.[]| select(.properties.\"application.name\" == \"$music_application_name\"))| .mute")
}
set_indexes

#==============================        eww volume sliders      ==============================  

case "$1" in 

    mic) #========================       microphone      ======================== 
        if [ $2 == "mute" ]; then
            pamixer --default-source -t
            mic=$(pamixer --get-volume-human --default-source | sed 's/%//g')

            if [ $mic == muted ]; then
                eww update micvolume="0"
            else
                eww update micvolume=$mic
            fi

        elif [ $2 == "vol-change" ]; then
            mic=$(pamixer --get-volume-human --default-source | sed 's/%//g')

            if [ "$mic" == "muted" ]; then
                echo 0
                eww update micvolume="0"
            else
                pamixer --default-source --set-volume $3
            fi

        elif [ $2 == "vol-up" ]; then
            mic=$(pamixer --get-volume-human --default-source | sed 's/%//g')

            if [ "$mic" == "muted" ]; then
                echo 0
                eww update micvolume="0"
            else
                pamixer --default-source -i 2
            fi

        elif [ $2 == "vol-down" ]; then
            mic=$(pamixer --get-volume-human --default-source | sed 's/%//g')

            if [ "$mic" == "muted" ]; then
                echo 0
                eww update micvolume="0"
            else
                pamixer --default-source -d 2
            fi
        fi
    ;;


    mon) #========================       monitor/speaker      ======================== 
        if [ $2 == "mute"  ]; then
            pamixer --sink "$mon_index" -t
            mon=$(pamixer --get-volume-human --sink "$mon_index" | sed 's/%//g')
            if [ $mon == muted ]; then
                eww update monvolume="0"
            else
                eww update monvolume=$mon
            fi

        elif [ $2 == "vol-change" ]; then
            mon=$(pamixer --get-volume-human --sink "$mon_index" | sed 's/%//g')

            if [ "$mon" == "muted" ]; then
                echo 0
                eww update monvolume="0"
            else
                pamixer --allow-boost --sink "$mon_index" --set-volume $3
            fi
        fi
    ;;


    head) #========================       headphones      ======================== 
        if [ "$2" == "mute" ]; then
            pamixer --sink "$head_index" -t
            head=$(pamixer --get-volume-human --sink "$head_index" | sed 's/%//g')
            if [ "$head" == "muted" ]; then
                eww update headvolume="0"
            else
                eww update headvolume=$head
            fi

        elif [ "$2" == "vol-change" ]; then
            head=$(pamixer --get-volume-human --sink "$head_index" | sed 's/%//g')
            if [ "$head" == "muted" ]; then
                echo 0
                eww update headvolume="0"
            else
                pamixer --allow-boost --sink "$head_index" --set-volume $3
            fi
        fi
    ;;


    music) #========================       music-player      ======================== 
        if [ "$2" == "mute" ]; then
            music_volume=$(pactl list sink-inputs | awk -v m_app="$music_application_name" '/Volume: front-left: /{gsub(" ","",$0); split($0, arr, "/"); m_id=arr[2]} /application.name/{if ($0~m_app) {gsub("%", "", m_id); print m_id}}')
            if [ $is_music_muted == true ]; then
                pactl set-sink-input-mute "$music_index" false

                eww update musicvolume=$music_volume
            elif [ $is_music_muted == false ];then
                pactl set-sink-input-mute "$music_index" true

                eww update musicvolume="0"
            fi


        elif [ "$2" == "vol-change" ]; then
            if [ $is_music_muted == true ]; then
                echo 0
                eww update musicvolume="0"
            else
                pactl set-sink-input-volume "$music_index" "$3"%
            fi
        fi
    ;;


    browser) #========================       browser      ======================== 
        if [ "$2" == "mute" ]; then
            browser_volume=$(pactl list sink-inputs | awk -v m_app="$browser_application_name" '/Volume: front-left: /{gsub(" ","",$0); split($0, arr, "/"); m_id=arr[2]} /application.name/ && $0 ~ m_app {gsub("%", "", m_id); print m_id; exit}')

            if [ $is_browser_muted == true ]; then
                for index in $browser_indexes; do
                    pactl set-sink-input-mute "$index" false
                done

                eww update browservolume=$browser_volume

            elif [ $is_browser_muted == false ];then
                for index in $browser_indexes; do
                    pactl set-sink-input-mute "$index" true
                done

                eww update browservolume="0"
            fi

        elif [ "$2" == "vol-change" ]; then
            if [ $is_browser_muted == true ]; then
                echo 0
                eww update browservolume="0"
            else
                for index in $browser_indexes; do
                    pactl set-sink-input-volume "$index" "$3"%
                done
            fi
        fi
    ;;

    poll)
        browser_poll() {
            b_vol=$(echo $pactl_json_sink_inputs | jq "first(.[]| select(.properties.\"application.name\" == \"$browser_application_name\"))| .volume.\"front-left\".value_percent" | sed 's/[\"%]//g')

            if [ -z "$b_vol" ]; then
                b_vol=0
            elif [ $is_browser_muted == true ]; then
                b_vol=0
            fi
        }

        music_poll() {
            m_vol=$(echo $pactl_json_sink_inputs | jq "first(.[]| select(.properties.\"application.name\" == \"$music_application_name\"))| .volume.\"front-left\".value_percent" | sed 's/[\"%]//g')

            if [ -z "$m_vol" ]; then
                m_vol=0
            elif [ $is_music_muted == true ]; then
                m_vol=0
            fi
        }

        print() {
            set_indexes

            browser_poll
            music_poll

            if [ -z $head_index ]; then
                head_vol=0
            else
                head_vol=$(pamixer --sink "$head_index" --get-volume-human | sed 's/%//g' | awk '{ if ($1 == "muted"){ print "0" } else { print $1 } }')
            fi

            if [ -z $mon_index ]; then
                mon_vol=0
            else
                mon_vol=$(pamixer --sink "$mon_index" --get-volume-human | sed 's/%//g' | awk '{ if ($1 == "muted"){ print "0" } else { print $1 } }')
            fi
            
            mic_vol=$(pamixer --get-volume-human --default-source | sed 's/%//g' | awk '{ if ($1 == "muted"){ print "0" } else { print $1 } }')

            echo "{\"browser\": $b_vol, \"music\": $m_vol, \"head\": $head_vol, \"mon\": $mon_vol, \"mic\": $mic_vol}"
        }

        print

        pactl subscribe | rg --line-buffered "on sink|on source" | while read -r _; do print; done
    ;;
esac

{pkgs, ...} @ args: {
  home.file."scripts/eww/player.sh".source = pkgs.writers.writeBash "player.sh" ''
    PATH="$HOME/scripts/eww:$PATH"
    music_application_name="${args.music_player}"
    browser_application_name="${args.browser}"
    active_player=$(playerctl --all-players metadata --format '{{playerName}}' | head -n 1)
    innactive_player=$(playerctl --all-players metadata --format '{{playerName}}' | tail -n 1)
    music_index=$(pactl list sink-inputs | awk -v m_app="$music_application_name" '/Sink Input #/{gsub("#","",$NF); m_id=$NF} /application.name/{if ($0~m_app) print m_id}')
    browser_indexes=$(pactl list sink-inputs | awk -v b_app="$browser_application_name" '/Sink Input #/{gsub("#","",$NF); b_id=$NF} /application.name/{if ($0~b_app) print b_id}')

    case $1 in
    poll)
        case $2 in
        player)
            playerctl metadata --format '{{ playerName}}'
        ;;
        title)
            playerctl metadata --format '{{ title }}'
        ;;
        artist)
            playerctl metadata --format '{{ artist }}'
        ;;
        status)
            sleep 0.1
            status=$(playerctl --player="$active_player" status)
            case $status in
            Playing)
                printf ""
                eww update status=""
            ;;
            Paused)
                printf ""
                eww update status=""
            ;;
            esac
        ;;
        update)
            artist=$(playerctl metadata --format '{{ artist }}')
            title=$(playerctl metadata --format '{{ title }}')
            active_player=$(playerctl --all-players metadata --format '{{playerName}}' | head -n 1)
            eww update player="$active_player"
            eww update artist="$artist"
            eww update title="$title"
            player poll status
        ;;
        length)
        input_time=$(playerctl metadata --format "{{ duration(mpris:length) }}")
        IFS=":" read -r hours minutes seconds <<< "$input_time"
        seconds=''${seconds#0}
        if [ -z $seconds ]; then
            total_seconds=$((hours * 60 + minutes + 1))
        else
            total_seconds=$((hours * 3600 + minutes * 60 + seconds + 1))
        fi
        printf "$total_seconds"
        ;;
        esac
    ;;
    change)
        pamixer -t
        playerctl --player="$innactive_player" play-pause
        playerctl --player="$innactive_player" play-pause
        sleep 0.1
        pamixer -t
        length=$(player poll length)
        eww update length="$length"
        player poll update
    ;;
    vol)
        case $2 in
        set)
            case $active_player in
            spotify)
            pactl set-sink-input-volume "$music_index" "$3"%
            ;;
            firefox)
            for index in $browser_indexes; do
                pactl set-sink-input-volume  "$index" "$3"%
            done
            ;;
            esac
        ;;
        esac

        case $active_player in
        spotify)
        if [ -z "$(pactl list sink-inputs | awk -v m_app="$music_application_name" '/Volume: front-left: /{gsub(" ","",$0); split($0, arr, "/"); m_id=arr[2]} /application.name/ && $0 ~ m_app {gsub("%", "", m_id); print m_id; exit}')" ]; then
            echo 0
        else
            pactl list sink-inputs | awk -v m_app="$music_application_name" '/Volume: front-left: /{gsub(" ","",$0); split($0, arr, "/"); m_id=arr[2]} /application.name/{if ($0~m_app) {gsub("%", "", m_id); print m_id}}'
        fi
        ;;
        firefox)
        if [ -z "$(pactl list sink-inputs | awk -v m_app="$browser_application_name" '/Volume: front-left: /{gsub(" ","",$0); split($0, arr, "/"); m_id=arr[2]} /application.name/ && $0 ~ m_app {gsub("%", "", m_id); print m_id; exit}')" ]; then
            echo 0
        else
            pactl list sink-inputs | awk -v m_app="$browser_application_name" '/Volume: front-left: /{gsub(" ","",$0); split($0, arr, "/"); m_id=arr[2]} /application.name/ && $0 ~ m_app {gsub("%", "", m_id); print m_id; exit}'
        fi
        ;;
        esac

    ;;
    esac
  '';
}

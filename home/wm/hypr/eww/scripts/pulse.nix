{pkgs, ...} @ args: {
  xdg.configFile."hypr/eww/scripts/pulse.sh".source = pkgs.writers.writeBash "pulse.sh" ''
    print() {
        sink=$(pamixer --get-volume-human | tr -d '%')
        source=$(pamixer --get-volume-human --default-source | tr -d '%')

        if [ -n "$(pamixer --get-default-sink | grep ${args.speakerSink})" ]; then
            if [ $sink == "muted" ]; then
                sink="$sink"
            elif [ $sink -gt 50 ]; then
                sink="$sink%"
            elif [ $sink -le 50 ]; then
                sink="$sink%"
            elif [ $sink -eq 0 ]; then
                sink="$sink%"
            fi
        else
            if [ $sink == "muted" ]; then
                sink="$sink"
            else
                sink="$sink%"
            fi
        fi

        if [ $source == "muted" ]; then
            source=""
        else
            source="$source%"
        fi

        echo "{\"sink\": \"$sink\", \"source\": \"$source\"}"
    }

    print

    pactl subscribe | rg --line-buffered "on sink|on source" | while read -r _; do
        print
    done
  '';
}

{pkgs, ...} @ args: {
  xdg.configFile."hypr/scripts/rgb.sh".source = pkgs.writers.writeBash "rgb.sh" ''
    case $1 in
        s)
            if pgrep -f "KeyboardVisualizer" > /dev/null; then
                pkill .KeyboardVisual
            else
                cd && KeyboardVisualizer
            fi
            exit;;
    esac

    profiles=$(ls ~/.config/OpenRGB | wc -l) && ((profiles -= 3))
    curr_profile=$(cat ~/.config/hypr/.rgb_profile)

    ((curr_profile += 1))

    if [ "$curr_profile" -gt "$profiles" ]; then
        echo 1 > ~/.config/hypr/.rgb_profile
        curr_profile=1
    else
        echo $curr_profile > ~/.config/hypr/.rgb_profile
    fi

    case $curr_profile in
        1)
            curr_profile=red ;;
        2)
            curr_profile=white ;;
        3)
            curr_profile=yellow ;;
        4)
            curr_profile=black ;;
        5)
            curr_profile=yellow ;;
        6)
            curr_profile=yellow ;;
        7)
            curr_profile=yellow ;;
        8)
            curr_profile=yellow ;;
        9)
            curr_profile=yellow ;;
        10)
            curr_profile=yellow ;;
    esac

    openrgb -p $curr_profile
  '';
}

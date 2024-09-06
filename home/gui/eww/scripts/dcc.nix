{pkgs, ...}: {
  home.file."scripts/eww/dcc.sh".source = pkgs.writers.writeBash "dcc.sh" ''
    mon_index=$((6 + $2))
    case $1 in
        b)
            ddccontrol -r 0x10 -w "$3" dev:/dev/i2c-$mon_index > /dev/null ;;
        c)
            ddccontrol -r 0x12 -w "$3" dev:/dev/i2c-$mon_index > /dev/null ;;
        read_b)
            ddccontrol -r 0x10 dev:/dev/i2c-$mon_index | grep Control | sed 's/.*+\/\([0-9]\+\)\/100.*/\1/'  ;;
        read_c)
            ddccontrol -r 0x12 dev:/dev/i2c-$mon_index | grep Control | sed 's/.*+\/\([0-9]\+\)\/100.*/\1/' ;;
    esac

  '';
}

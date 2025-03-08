{pkgs, ...}: {
  xdg.configFile."i3/kbi3.sh".source = pkgs.writers.writeBash "kbi3.sh" ''
    layout=$(setxkbmap -query | grep variant | sed 's/variant:    //')

    if [ -z "$layout" ]; then
        setxkbmap us dvorak
        dunstify layout "changed to: dvorak"
    elif [ "$layout" = "dvorak" ]; then
        setxkbmap bg phonetic
        dunstify layout "changed to: bg"
    else
        setxkbmap us
        dunstify layout "changed to: qwerty"
    fi
  '';
}

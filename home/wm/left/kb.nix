{pkgs, ...}: {
  xdg.configFile."leftwm/themes/current/kb.sh".source = pkgs.writers.writeBash "kb.sh" ''
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

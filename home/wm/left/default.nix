{pkgs, ...}: {
  home.file.".Xresources".text = ''
    Xft.dpi: 192
  '';

  # TODO: add & start polkit
  home.file.".xinitrc".text = ''
    xrdb ~/.Xresources &
    xautolock -locker "i3lock -c 000000" -notifier "dunstify 'locking in 5'" -notify 300 &
    exec leftwm
  '';
  xdg.configFile."leftwm".source = ./leftwm;

  # TODO: remove alacritty
  home.packages = with pkgs; [
    alacritty
    dunst
    rofi
    eww
    i3lock
    picom
    xautolock
  ];
}

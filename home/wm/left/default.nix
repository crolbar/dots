{pkgs, ...}: {
  imports = [
    ../share/picom.nix
    ../share/dunst.nix
    ../share/rofi
    ../share/x11
  ];

  home.file.".Xresources".text = ''
    Xft.dpi: 192
  '';

  home.file.".xinitrc".text = ''
    xrdb ~/.Xresources &
    xautolock -locker "i3lock -c 000000" -notifier "dunstify 'locking in 5'" -notify 300 &
    exec leftwm
  '';
  xdg.configFile."leftwm".source = ./leftwm;

  home.packages = with pkgs; [
    eww
    xautolock
    feh

    brightnessctl
    light
    alsa-utils # amixer
  ];
}

{pkgs, ...}: {
  imports = [
    ../share/picom.nix
    ../share/dunst.nix
    ../share/rofi
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
    alacritty
    eww
    i3lock
    xautolock
    feh
  ];
}

{
  pkgs,
  username,
  ...
}: {
  imports = [
    ../share/picom.nix
    ../share/dunst.nix
    ../share/rofi
    ../share/x11
  ];

  home.file.".Xresources".text =
    if username == "plier"
    then "Xft.dpi: 192"
    else "";

  home.file.".xinitrc".text =
    # somehow found it from: https://discourse.nixos.org/t/how-to-start-user-units-when-using-startx/16919/2
    # without this the xdg portal doesn't work
    ''
      dbus-daemon --session --address="unix:path=$XDG_RUNTIME_DIR/bus" &
    ''
    + ''
      xrdb ~/.Xresources &
      ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &
      xautolock -locker "i3lock -c 000000" -notifier "dunstify 'locking in 5'" -notify 300 &
      exec leftwm
    '';
  xdg.configFile."leftwm".source = ./leftwm;

  home.packages = with pkgs; [
    eww
    xautolock
    polkit_gnome

    brightnessctl
    light
    alsa-utils # amixer
  ];
}

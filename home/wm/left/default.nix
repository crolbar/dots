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
    # https://nixos.wiki/wiki/Using_X_without_a_Display_Manager
    # without it the xdg portal doesn't work on
    ''
      if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
          eval $(dbus-launch --exit-with-session --sh-syntax)
      fi
      systemctl --user import-environment DISPLAY XAUTHORITY

      if command -v dbus-update-activation-environment >/dev/null 2>&1; then
          dbus-update-activation-environment DISPLAY XAUTHORITY
      fi
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
    feh
    polkit_gnome

    brightnessctl
    light
    alsa-utils # amixer
  ];
}

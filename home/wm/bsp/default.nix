{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./sxhkd.nix
    ./polybar.nix

    ../share/dunst.nix
    ../share/picom.nix
    ../share/rofi
    ../share/x11
  ];

  home.packages = with pkgs; [
    polkit_gnome
    xautolock
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
      exec bspwm
    '';

  xdg.configFile."bspwm/scripts".source = ./bspwm/scripts;

  xsession.windowManager.bspwm = {
    enable = true;
    extraConfigEarly = ''
      PATH="$HOME/.config/bspwm/scripts:$PATH"

      for monitor in $(bspc query -M); do
          bspc monitor $monitor -d {1,2,3,4,5,6,7}
      done
    '';

    settings = {
      border_width = 2;
      window_gap = 5;
      focused_border_color = "#A7A4E0";
      split_ratio = 0.52;
      borderless_monocle = true;
      gapless_monocle = true;
      single_monocle = true;
      focus_follows_pointer = true;
      pointer_follows_focus = false;
      pointer_motion_interval = 20;
      automatic_scheme = "alternate";
    };

    rules = {
      "Eww" = {
        follow = false;
        state = "floating";
      };
      "pavucontrol" = {
        follow = false;
        state = "floating";
      };
    };

    extraConfig = ''
      processes=("picom" "polybar" "sxhkd" "dunst")
      for process in "''${processes[@]}"; do
        if pidof -q "$process"; then
         pkill -9 "$process" > /dev/null; sleep 0.1
        fi
      done

      sxhkd &
      dunst &
      polybar &
      picom &
      wall i &
    '';
  };
}

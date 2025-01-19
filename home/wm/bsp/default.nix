{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./sxhkd.nix
    ./eww

    ../share/dunst.nix
    ../share/picom.nix
    ../share/rofi
    ../share/x11
    ../share/wall
  ];

  home.packages = with pkgs; [
    polkit_gnome
    xautolock
  ];

  home.file.".Xresources".text =
    if username == "plier"
    then "Xft.dpi: 192"
    else "";

  home.file.".xinitrc".text = ''
    dbus-daemon --session --address="unix:path=$XDG_RUNTIME_DIR/bus" &
    xrdb ~/.Xresources &
    ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &
    exec bspwm
  '';

  xsession.windowManager.bspwm = {
    enable = true;
    monitors.DP-0 = ["0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "10"];

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
      processes=("picom" "eww" "sxhkd" "dunst")
      for process in "''${processes[@]}"; do
        if pidof -q "$process"; then
         pkill -9 "$process" > /dev/null; sleep 0.1
        fi
      done

      sxhkd &
      dunst &
      picom &
      eww -c ~/.config/bspwm/eww open bar

      ~/scripts/wall.sh i

      xset r rate 300 50
    '';
  };
}

{
  imports = [
    ./sxhkd.nix
    ./polybar.nix

    ../share/dunst.nix
    ../share/picom.nix
    ../share/rofi
    ../share/x11
  ];

  home.file.".xinitrc".text = "exec bspwm";
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

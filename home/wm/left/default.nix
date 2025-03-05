{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./binds.nix
    ./kb.nix

    ../share/scripts
    ../share/picom.nix
    ../share/dunst.nix
    ../share/rofi
    ../share/x11
    ../share/wall
    ../share/binds
  ];

  home.file.".Xresources".text =
    if username == "plier"
    then "Xft.dpi: 192"
    else "";

  home.file.".xinitrc".text =
    # https://discourse.nixos.org/t/how-to-start-user-units-when-using-startx/16919/2
    ''
      dbus-daemon --session --address="unix:path=$XDG_RUNTIME_DIR/bus" &
    ''
    + ''
      xrdb ~/.Xresources &
      ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &

      xset r rate 300 50

      YUKI_MOUSE_ID=$(xinput list | grep "crolbar YUKI" | grep "pointer" | sed -n 's/.*id=\([0-9]*\).*/\1/p')
      xinput --set-prop $YUKI_MOUSE_ID "libinput Accel Profile Enabled" 1 0
      xinput --set-prop $YUKI_MOUSE_ID "libinput Accel Speed" 1

      exec leftwm
    '';

  xdg.configFile."leftwm/themes/current/eww".source = ./eww;

  programs.leftwm = {
    enable = true;
    package = pkgs.leftwm;

    extraPackages = with pkgs; [
      eww
      polkit_gnome

      brightnessctl
      light
      alsa-utils # amixer
    ];

    theme = {
      border_width = 1;
      margin = 0;
      default_border_color = "#000000";
      floating_border_color = "#DE64AC";
      focused_border_color = "#DE64AC";
    };

    startupPrograms = [
      "picom"
      "~/scripts/wall.sh i"
      "eww open btm_tray -c ~/.config/leftwm/themes/current/eww"
      "eww open tags -c ~/.config/leftwm/themes/current/eww"
      "dunst"
    ];

    up = ''
      export SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

      processes=("eww" "feh" "dunst" "bat" "picom")
      for process in "''${processes[@]}"; do
          if pidof -q "$process"; then
              pkill -x "$process" > /dev/null
          fi
      done

      if [ -f "/tmp/leftwm-theme-down" ]; then
          /tmp/leftwm-theme-down
          rm /tmp/leftwm-theme-down
      fi
      ln -s $SCRIPTPATH/down /tmp/leftwm-theme-down

      leftwm-command "LoadTheme $SCRIPTPATH/theme.ron"
    '';

    down = ''
      leftwm-command "UnloadTheme"
    '';

    settings = import ./settings.nix;
  };
}

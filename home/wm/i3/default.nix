{
  pkgs,
  username,
  lib,
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

  home.file.".xinitrc".text = ''
    dbus-daemon --session --address="unix:path=$XDG_RUNTIME_DIR/bus" &
    xrdb ~/.Xresources &
    ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &

    xset r rate 300 50

    YUKI_MOUSE_ID=$(xinput list | grep "crolbar YUKI" | grep "pointer" | sed -n 's/.*id=\([0-9]*\).*/\1/p')
    xinput --set-prop $YUKI_MOUSE_ID "libinput Accel Profile Enabled" 1 0
    xinput --set-prop $YUKI_MOUSE_ID "libinput Accel Speed" 1

    sudo systemctl start volSock
    exec i3
  '';

  xsession.windowManager.i3 = {
    enable = true;
    extraConfig = ''
      for_window [class="^.*"] border pixel 1
      for_window [class="pavucontrol"] floating enable
    '';

    config = let
      accentColor = "#c83232"; #5f00ff
      dark = "#3C0F0F";
    in {
      workspaceLayout = "default"; # "default", "stacking", "tabbed"
      window = {
        titlebar = true;
        hideEdgeBorders = "smart"; # "none", "vertical", "horizontal", "both", "smart"
        border = 1;
      };
      gaps = {
        smartBorders = "off";
        smartGaps = true;
      };

      terminal = "alacritty";

      startup = let
        mk = cmd: {command = cmd;};
      in [
        (mk "${lib.getExe pkgs.playerctl} daemon")
        (mk "~/scripts/wall.sh i")
        (mk "${lib.getExe' pkgs.networkmanagerapplet "nm-applet"}")
        (mk "${lib.getExe pkgs.dunst}")
      ];

      modifier = "Mod4";

      colors = {
        focused = {
          border = "#333333";
          background = dark;
          text = "#ffffff";
          indicator = "#4fcf90";
          childBorder = accentColor;
        };
      };

      bars = [
        {
          statusCommand = "${lib.getExe pkgs.i3status}";
          colors = {
            focusedWorkspace = {
              border = "#333333";
              background = accentColor;
              text = "#ffffff";
            };
          };
        }
      ];
    };
  };
}

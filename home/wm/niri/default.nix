{pkgs, ...}: {
  imports = [
    ./binds.nix
    #./settings.nix
    #./eww

    ../share/wayland
    ../share/dunst.nix
    ../share/wall
  ];

  home.packages = with pkgs; [
    xwayland-satellite
  ];

  programs.niri = {
    enable = true;

    settings = {
      environment = {
        MOZ_ENABLE_WAYLAND = "1";
        DISPLAY = ":0";
      };

      spawn-at-startup = [
        {command = ["xwayland-satellite"];}
        {command = ["playerctld" "daemon"];}
        {command = ["dunst"];}
        {command = ["~/scripts/wall.sh i"];}
        {command = ["${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"];}
        {command = ["nm-applet"];}
        {command = ["swww-daemon"];}
        {command = ["sh" "-c" ''dbus-daemon --session --address="unix:path=$XDG_RUNTIME_DIR/bus"''];}
      ];

      prefer-no-csd = true;

      workspaces = {
        "1" = {};
        "2" = {};
        "3" = {};
        "4" = {};
        "5" = {};
        "6" = {};
        "7" = {};
        "8" = {};
        "9" = {};
        "0" = {};
        "10" = {};
      };
      input = {
        keyboard = {
          repeat-rate = 50;
          repeat-delay = 300;
        };
      };
    };
  };
}

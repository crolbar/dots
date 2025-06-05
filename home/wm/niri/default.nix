{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./binds.nix
    #./settings.nix
    ./eww

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
        "0" = {};
        "1" = {};
        "2" = {};
        "3" = {};
        "4" = {};
        "5" = {};
        "6" = {};
        "7" = {};
        "8" = {};
        "9" = {};
        # apperantly order of workspaces in the kbl file matters
        # and nix attrsets are just sorted alphabetically
        # a > 9.. so 10 is after 9 not after 1
        "a" = {name = "10";};
      };

      input = {
        warp-mouse-to-focus = true;
        focus-follows-mouse.enable = true;


        keyboard = {
          repeat-rate = 50;
          repeat-delay = 300;
          xkb = {
            layout = "us,us,bg";
            variant = ",dvorak,phonetic";
            options = "grp:win_space_toggle";
          };
        };

        mouse = {
          #accel-profile = "adaptive"; # flat/adaptive
          #accel-speed = -0.4;
        };

        touchpad = {
          accel-profile = "adaptive"; # flat/adaptive
          accel-speed = -0.4;
          natural-scroll = false;
        };
      };
    };
  };
}

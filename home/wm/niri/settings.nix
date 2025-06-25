{pkgs, ...}: let
  cursor = "capitaine-cursors-white";
in {
  programs.niri.settings = {
    environment = {
      MOZ_ENABLE_WAYLAND = "1";
      DISPLAY = ":0";
      NIXOS_OZONE_WL = "1";
    };

    hotkey-overlay.skip-at-startup = true;

    prefer-no-csd = true;

    cursor = {
      hide-after-inactive-ms = 5000;
      size = 24;
      theme = cursor;
    };

    spawn-at-startup = [
      {command = ["sh" "-c" ''dbus-daemon --session --address="unix:path=$XDG_RUNTIME_DIR/bus"''];}
      {command = ["xwayland-satellite"];}

      {command = ["playerctld" "daemon"];}
      {command = ["dunst"];}
      {command = ["~/scripts/wall.sh i"];}
      {command = ["${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"];}
      {command = ["nm-applet"];}
      {command = ["swww-daemon"];}
      {command = ["sh" "-c" "eww -c ~/.config/niri/eww daemon && eww -c ~/.config/niri/eww open btm_tray & eww -c ~/.config/niri/eww open tags &"];}
    ];

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
          options = "grp:win_space_toggle, ctrl:swap_ralt_rctl";
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

    outputs = {
      eDP-1 = {
        position = {
          x = 0;
          y = 0;
        };
        transform = {
          flipped = false;
          rotation = 0;
        };
        mode = {
          width = 3200;
          height = 2000;
          refresh = 120.000;
        };
        scale = 2.0;
      };
    };

    layout = {
      focus-ring = {
        enable = true;
        width = 1;
        active.gradient = {
          angle = 125;
          from = "#DE64AC";
          to = "#000000";
        };
        inactive.color = "#000000";
      };

      insert-hint = {
        enable = true;
        display.color = "#909090";
      };

      tab-indicator = {
        enable = true;
        corner-radius = 2;
        gap = 4;
        gaps-between-tabs = 0;
        hide-when-single-tab = false;
        position = "left";
        width = 6;
      };

      gaps = 15;
    };

    gestures.hot-corners.enable = false;
  };
}

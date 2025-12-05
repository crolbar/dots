{
  pkgs,
  username,
  lib,
  config,
  ...
}: let
  cursor = "capitaine-cursors-white";
in {
  programs.niri.settings = {
    environment = {
      MOZ_ENABLE_WAYLAND = "1";
      DISPLAY = ":0";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "niri";
      PROTON_USE_NTSYNC = "1";
      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland";
      SDL_VIDEODRIVER = "wayland";
    };

    hotkey-overlay.skip-at-startup = true;

    prefer-no-csd = true;

    cursor = {
      hide-after-inactive-ms = 5000;
      size = 24;
      theme = cursor;
    };

    spawn-at-startup = let
      sh = cmd: {command = ["sh" "-c" cmd];};
      c = cmd: {command = [cmd];};
      xwayland-satellite = lib.getExe pkgs.xwayland-satellite;
      eww = lib.getExe pkgs.eww;
      dunst = lib.getExe pkgs.dunst;
      wallI = "${config.home.file."scripts/wall.sh".source} i";
      nm-applet = lib.getExe' pkgs.networkmanagerapplet "nm-applet";
      swww-daemon = lib.getExe' pkgs.swww "swww-daemon";

      barOpen = let
        ewwOpen = bar: "${eww} -c ~/.config/niri/eww open ${bar} &";
      in
        if username == "plier"
        then (ewwOpen "tags") + " " + (ewwOpen "btm_tray")
        else (ewwOpen "bar");
    in [
      (c xwayland-satellite)

      (c dunst)
      (c "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1")
      (c nm-applet)
      (c swww-daemon)
      (c wallI)
      (sh "${eww} -c ~/.config/niri/eww daemon && ${barOpen}")
      (sh "systemctl --user stop niri-session.target && systemctl --user start niri-session.target")
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
      warp-mouse-to-focus.enable = false;
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
        accel-profile = "adaptive"; # flat/adaptive
        accel-speed = -0.9;
      };

      touchpad = {
        accel-profile = "adaptive"; # flat/adaptive
        accel-speed = -0.4;
        natural-scroll = false;
      };
    };

    outputs = {
      # plier
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
        scale = 1.5;
      };

      # plier
      # HDMI-A-1 = {
      #   mode = {
      #     width = 3840;
      #     height = 2160;
      #     refresh = 60.000;
      #   };
      #   scale = 2.0;
      # };

      # 308
      DP-1 = {
        position = {
          x = 1080;
          y = 1080;
          # x = 0;
          # y = 0;
        };
        mode = {
          width = 3840;
          height = 2160;
          refresh = 120.000;
        };
        scale = 1.5;
      };
      HDMI-A-1 = {
        position = {
          x = 0;
          y = 230;
        };
        transform = {
          flipped = false;
          rotation = 270;
        };
        mode = {
          width = 1920;
          height = 1080;
          refresh = 144.000;
        };
      };
      DP-2 = {
        position = {
          x = 1080;
          y = 0;
        };
        mode = {
          width = 1920;
          height = 1080;
          refresh = 60.000;
        };
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
        hide-when-single-tab = false;
        corner-radius = 0;
        gap = 1;
        gaps-between-tabs = 2;
        position = "top";
        length.total-proportion = 1.001000;
        width = config.programs.niri.settings.layout.gaps;
        inactive.color = "#282828";
      };

      gaps = 15;

      background-color = "transparent";
    };

    gestures.hot-corners.enable = true;

    window-rules = let
      app = app-id: rules:
        {matches = [{inherit app-id;}];}
        // builtins.foldl' (acc: e: acc // e) {} rules;

      block = {block-out-from = "screen-capture";};
      float = {open-floating = true;};
      unfocused = {open-focused = false;};
      workspace = w: {open-on-workspace = w;};
      float-pos = x: y: relative-to: {
        default-floating-position = {
          inherit x y relative-to;
        };
      };
    in [
      # (app "hooktty" [float block unfocused (float-pos 0 0 "top-right") {draw-border-with-background = false;}])
      (app "KeePassXC" [block])

      (app "steam" [(workspace "8")])

      (app "com.mitchellh.ghostty" [{draw-border-with-background = false;}])
    ];

    layer-rules = [
      {
        matches = [{namespace = "swww-daemon";}];
        place-within-backdrop = true;
      }
    ];

    screenshot-path = "~/Screenshots/Screenshot-%F_%T.png";
  };
}

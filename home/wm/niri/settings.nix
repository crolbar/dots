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
      NIXOS_OZONE_WL = "1";
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
      playerctld = lib.getExe' pkgs.playerctl "playerctld";
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
      (sh ''dbus-daemon --session --address="unix:path=$XDG_RUNTIME_DIR/bus"'')
      (c xwayland-satellite)

      {command = [playerctld "daemon"];}
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
      DP-1 = {
        position = {
          x = 1080;
          y = 1080;
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
        corner-radius = 2;
        gap = 4;
        gaps-between-tabs = 0;
        hide-when-single-tab = false;
        position = "left";
        width = 6;
      };

      gaps = 15;
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
    in [
      (app "hooktty" [float block unfocused])
      (app "KeePassXC" [block])

      (app "steam" [(workspace "8")])

      (app "com.mitchellh.ghostty" [{draw-border-with-background = false;}])
    ];

    screenshot-path = "~/Screenshots/Screenshot-%F_%T.png";
  };
}

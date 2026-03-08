{
  pkgs,
  username,
  ...
}: let
  cursor = "capitaine-cursors-white";
in {
  wayland.windowManager.hyprland.settings = {
    monitorv2 =
      if username == "plier"
      then [
        {
          output = "eDP-1";
          mode = "3200x2000@120";
          position = "0x0";
          scale = 2;
        }
      ]
      else if username == "crolbar"
      then [
        {
          output = "DP-1";
          mode = "3840x2160@120";
          # mode = "2560x1440@120";
          # mode = "1920x1080@120";
          position = "1080x1080";
          scale = 1.5;
        }

        {
          output = "DP-2";
          mode = "1920x1080@75";
          position = "1080x0";
          scale = 1;
        }

        {
          output = "HDMI-A-1";
          mode = "1920x1080@144.00Hz";
          position = "0x600";
          scale = 1;
          transform = 3;
        }
      ]
      else [];

    # startup apps
    exec-once = [
      "dunst"
      "~/scripts/wall.sh i"
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &"
      "nm-applet &"
      "eww -c ~/.config/hypr/eww open bar"
      "awww-daemon"
    ];

    workspace = [
      # no gaps on single workspace
      "w[tv1], gapsout:0, gapsin:0"
      "f[1], gapsout:0, gapsin:0"
    ];

    windowrule = [
      # no border on single window on workspace
      "border_size 0,match:workspace w[t1]"

      "match:title crolk, float on"
      "opacity 0.85 0.85, match:class spotify"
      "opacity 0.9 0.9, match:class mousepad"
      "workspace 4, match:class spotify"
      "workspace 8, match:class steam"

      "match:class ^(steam_app).*, immediate on"
    ];

    # env vars
    env =
      [
        "XCURSOR_SIZE,20"
        "XCURSOR_THEME,${cursor}"
      ]
      ++ (
        if username == "crolbar"
        then [
          "LIBVA_DRIVER_NAME,nvidia"
          "XDG_SESSION_TYPE,wayland"
          "GBM_BACKEND,nvidia-drm"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        ]
        else []
      );

    cursor = {
      no_hardware_cursors = true;
    };

    input = {
      sensitivity = -0.9;
      kb_options = "grp:win_space_toggle";
      kb_layout = "us,us,bg";
      kb_variant = ",dvorak,phonetic";

      repeat_rate = "50";
      repeat_delay = "300";
    };

    device = {
      name = "crolbar-yuki-1";
      accel_profile = "adaptive";
      sensitivity = -0.2;
    };

    general = {
      gaps_in = 2;
      gaps_out = 7;
      border_size = 2;
      layout = "dwindle";

      "col.active_border" = "rgb(f5f5dc) rgb(e4b3a0) 45deg";
      "col.inactive_border" = "rgb(000000)";
    };

    ecosystem = {
      no_update_news = true;
      no_donation_nag = true;
      enforce_permissions = false;
    };

    misc = {
      disable_hyprland_logo = true;
      background_color = "0x000000";
      mouse_move_enables_dpms = true;
      enable_anr_dialog = true; # app not responding
    };

    render = {
      direct_scanout = 1; # 0 off, 1 on, 2 auto (on with content type ‘game’)
    };

    xwayland = {
      force_zero_scaling = true; # steam and games don't scale up good
    };

    decoration = {
      rounding = 4;
      shadow.enabled = false;
      blur.enabled = false;
    };

    animations = {
      enabled = true;

      bezier = [
        "fast, 0, 1, 0.5, 1"
        "zoom, 0, 0.5, 0.5, 1"
      ];
      animation = [
        "workspaces, 1, 1.5, fast, slidevert"

        "zoomFactor, 1, 2, zoom"

        # windows
        "windowsIn, 1, 3, fast, popin"
        "fadeIn, 1, 2, fast"
        "windowsOut, 1, 3, fast, slide"
        "fadeOut, 1, 1, fast"
        "windowsMove, 1, 3, fast, gnomed"
      ];
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    binds = {
      scroll_event_delay = 1;
    };
  };
}

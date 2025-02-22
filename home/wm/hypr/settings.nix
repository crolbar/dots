{
  pkgs,
  username,
  ...
}: let
  cursor = "capitaine-cursors-white";
in {
  wayland.windowManager.hyprland.settings = {
    # monitors
    monitor =
      if username == "plier"
      then "eDP-1,3200x2000@120,0x0,2"
      else #"DP-1,1920x1080@144,0x0,1";
        [
          "DP-1,1920x1080@144,1080x1080,1"
          #"DP-1,1024x768@119.99,1080x1080,1"
          "DP-2,1920x1080@75,1080x0,1"
          "HDMI-A-1,1920x1080@60,0x70,1,transform,3"
        ];

    #monitor = [
    #  "HDMI-A-1,1920x1080@60,0x1080,1"
    #  "DP-1,1920x1080@144,0x0,1"
    #];

    # startup apps
    exec-once = [
      "playerctld daemon"
      "dunst"
      "~/scripts/wall.sh i"
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &"
      "nm-applet &"
      "eww -c ~/.config/hypr/eww/ open bar"
      "swww-daemon"
    ];

    # windowrules
    windowrule = [
      "float, feh"
      "float, pavucontrol"
      "float, mousepad"
      "float, steam"
      "move 960 30, pavucontrol"
    ];

    workspace = [
      "w[tv1], gapsout:0, gapsin:0"
      "f[1], gapsout:0, gapsin:0"
    ];

    windowrulev2 = [
      "float, title:(enc) "
      "float, title:(crolk) "
      "opacity 0.85 0.85, initialTitle:(Spotify)"
      "opacity 0.9 0.9,class:^(mousepad)$"
      "workspace 4, initialTitle:(Spotify)"
      "workspace 8, initialTitle:(Steam)"

      "bordersize 0, floating:0, onworkspace:w[tv1]"
      "rounding 0, floating:0, onworkspace:w[tv1]"
      "bordersize 0, floating:0, onworkspace:f[1]"
      "rounding 0, floating:0, onworkspace:f[1]"
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

    misc = {
      disable_hyprland_logo = true;
      background_color = "0x000000";
      mouse_move_enables_dpms = true;
    };

    render = {
      explicit_sync = true;
    };

    # variables
    general = {
      gaps_in = 2;
      gaps_out = 2;
      border_size = 1;
      layout = "dwindle";
      "col.active_border" = "rgba(EFBBFFee) rgba(BAE1FFee) -30deg";
      "col.inactive_border" = "rgb(000000)";
    };

    decoration = {
      rounding = 4;
      shadow.enabled = false;
      blur.enabled = false;
    };

    animations = {
      enabled = true;

      bezier = [
        "cubic, 0, 1, 0.1, 1"
        "workspace, 0.3, 1, 0.3, 1"
      ];
      animation = [
        "windows, 1, 3, cubic"
        "windowsIn, 1, 3, cubic, slide"
        "windowsOut, 1, 3, cubic, slide"
        "windowsMove, 1, 3, cubic, slide"
        "fade, 1, 3, cubic"

        # idk if this is working on nvidia but
        # on my laptop there is an anoing red bar on unfocused windows for 2 secs
        "border, 0, 10, default"
        "fade, 1, 3, workspace"
        "workspaces, 1, 3, workspace"
      ];
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };
  };
}

{
  lib,
  pkgs,
  ...
}: let
  cursor = "capitaine-cursors-white";
in {
  wayland.windowManager.river = rec {
    # `https://codeberg.org/river/river/src/branch/master/example/init`
    settings = {
      spawn = [
        "playerctld daemon"
        "dunst"
        "~/scripts/wall.sh i"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "nm-applet"
        "swww-daemon"
      ];

      # `lswt` to get id and name
      rule-add = {
        # alt -app-id
        "-title" = {
          "'*'" = "ssd"; # alt float|ssd|tags|position|dimensions|fullscreen
        };
      };

      xcursor-theme = "${cursor} 20";

      border-width = 1;
      border-color-focused = "0xDE64AC";
      border-color-unfocused = "0x000000";

      default-layout = "wideriver";

      declare-mode = [
        "locked"
        "normal"
        "passthrough"
      ];

      input = {
        "'*'" = {
          accel-profile = "adaptive"; # alt flat,none
          pointer-accel = -0.4;
        };
        "pointer-1267-12817-ASUE1211:00_04F3:3211_Touchpad" = {
          tap = "enabled";
        };
      };

      set-repeat = "50 300";

      keyboard-layout = "-variant \",dvorak,phonetic\" -options \"grp:win_space_toggle\" \"us,us,bg\"";

      focus-follows-cursor = "always";
      set-cursor-warp = "on-focus-change";
      default-attach-mode = "below"; # spawn in slave
    };

    extraConfig = ''
      dbus-daemon --session --address="unix:path=$XDG_RUNTIME_DIR/bus" &
      ${lib.getExe pkgs.wideriver} \
          --layout                       left        \
          --layout-alt                   monocle     \
          --stack                        even        \
          --count-master                 1           \
          --ratio-master                 0.50        \
          --inner-gaps                   0           \
          --outer-gaps                   0           \
          --smart-gaps                               \
          --border-width                 1           \
          --border-width-monocle         0           \
          --border-width-smart-gaps      0           \
          --border-color-focused         "${settings.border-color-focused}"  \
          --border-color-focused-monocle "${settings.border-color-focused}"  \
          --border-color-unfocused       "${settings.border-color-unfocused}"  \
          --log-threshold                info        \
         > "/tmp/wideriver.$${XDG_VTNR}.$${USER}.log" 2>&1 &

      eww -c ~/.config/river/eww daemon && eww -c ~/.config/river/eww open btm_tray & eww -c ~/.config/river/eww open tags &
    '';
  };
}

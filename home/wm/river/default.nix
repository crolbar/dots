{pkgs, ...}: let
  cursor = "capitaine-cursors-white";
in {
  imports = [
    ./binds.nix
    ./kanshi.nix

    ../share/wayland
    ../share/dunst.nix
    ../share/wall
  ];

  home.packages = with pkgs; [
    polkit_gnome
    eww
    scriptisto # for c scripts
  ];

  wayland.windowManager.river = {
    enable = true;

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

      default-layout = "rivertile";

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
      default-attach-mode = "below"; # spawn in slave
    };

    extraConfig = ''
      dbus-daemon --session --address="unix:path=$XDG_RUNTIME_DIR/bus" &
      systemctl start --user kanshi
      rivertile -view-padding 0 -outer-padding 0 -main-ratio 0.5 &
    '';
  };
}

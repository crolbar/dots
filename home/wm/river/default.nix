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
      border-width = 1;
      border-color-focused = "0xDE64AC";
      border-color-unfocused = "0x000000";

      declare-mode = [
        "locked"
        "normal"
        "passthrough"
      ];

      input = {};

      rule-add = {
        "-title" = {
          "'*'" = "ssd";
        };
      };

      set-repeat = "50 300";

      spawn = [
        "playerctld daemon"
        "dunst"
        "~/scripts/wall.sh i"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "nm-applet"
        "eww -c ~/.config/hypr/eww/ open bar"
        "swww-daemon"
      ];

      keyboard-layout = "-variant \",dvorak,phonetic\" -options \"grp:win_space_toggle\" \"us,us,bg\"";

      xcursor-theme = "${cursor} 20";
      default-layout = "rivertile";
      output-layout = "rivertile";
    };

    extraConfig = ''
      rivertile -view-padding 0 -outer-padding 0 -main-ratio 0.5 &
    '';
  };
}

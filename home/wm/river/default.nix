{pkgs, ...}: let
  cursor = "capitaine-cursors-white";
in {
  imports = [
    ../share/wayland
    ../share/dunst.nix
    ../share/wall
  ];

  home.packages = with pkgs; [
    polkit_gnome
    eww
    scriptisto # for c scripts
    way-displays
  ];

  wayland.windowManager.river = {
    enable = true;
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

      map = {
        normal = {
          # Super Shift Alt Control
          "Super x" = "spawn alacritty";
          "Super+Shift X" = "spawn foot";
          "Super b" = "spawn schizofox";
          "Super m" = "spawn spotify";
          "Super r" = "spawn anyrun";

          "Super+Shift Q" = "close";
          "Super z" = "toggle-float";
          "Super f" = "toggle-fullscreen";
          "Super+Shift+Alt+Control q" = "exit";

          "Super j" = "focus-view next";
          "Super k" = "focus-view previous";

          "Super+Shift J" = "swap next";
          "Super+Shift K" = "swap previous";

          "Super Return" = "zoom";

          "Super BTN_LEFT" = "move-view";
          "Super BTN_RIGHT" = "resize-view";

          "Super 1" = "set-focused-tags 1";
          "Super 2" = "set-focused-tags 2";
          "Super 3" = "set-focused-tags 4";
          "Super 4" = "set-focused-tags 8";
          "Super 5" = "set-focused-tags 16";
          "Super 6" = "set-focused-tags 32";
          "Super 7" = "set-focused-tags 64";
          "Super 8" = "set-focused-tags 128";
          "Super 9" = "set-focused-tags 256";
          "Super 10" = "set-focused-tags 512";

          "Super+Shift 1" = "set-view-tags 1";
          "Super+Shift 2" = "set-view-tags 2";
          "Super+Shift 3" = "set-view-tags 4";
          "Super+Shift 4" = "set-view-tags 8";
          "Super+Shift 5" = "set-view-tags 16";
          "Super+Shift 6" = "set-view-tags 32";
          "Super+Shift 7" = "set-view-tags 64";
          "Super+Shift 8" = "set-view-tags 128";
          "Super+Shift 9" = "set-view-tags 256";
          "Super+Shift 10" = "set-view-tags 512";

          # EWW
          "Super s" = "spawn \"eww open board --toggle\"";
          "Super w" = "spawn \"eww -c ~/.config/hypr/eww/ open bar --toggle\"";
          "Super+Shift s" = "spawn \"pkill eww\"";

          # Wall
          "Super a" = "spawn \"~/scripts/wall.sh f\"";
          "Super+Shift a" = "spawn \"~/scripts/wall.sh b\"";
          "Super+ALT a" = "spawn \"~/scripts/wall.sh f f\"";
          "Super+Shift+Alt A" = "spawn \"~/scripts/wall.sh b f\"";
          "Super c" = "spawn \"swww clear\"";
        };
      };

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
        #"way-displays > /tmp/way-displays.$${XDG_VTNR}.$${USER}.log 2>&1"
      ];

      xcursor-theme = "${cursor} 20";
      default-layout = "rivertile";
      output-layout = "rivertile";
    };

    extraConfig = ''
      rivertile -view-padding 0 -outer-padding 0 &
    '';
  };
}

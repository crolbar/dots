{
  pkgs,
  lib,
  config,
  ...
} @ attr: {
  imports = [../share/binds];

  cbinds.windowManager.red = {
    enable = true;
    settings = {
      isRed = true;
      keys = {
        mod = "RED_MOD_SUPER";
        shift = "RED_MOD_SHIFT";
        ctrl = "RED_MOD_CTRL";
        alt = "RED_MOD_ALT";
        print = "Print";
        tab = "Tab";
        space = "space";
        media = {
          play = "XF86AudioPlay";
          next = "XF86AudioNext";
          prev = "XF86AudioPrev";
          lowerVolume = "XF86AudioLowerVolume";
          raiseVolume = "XF86AudioRaiseVolume";
        };
      };

      cmds = {
        exec = "spawn";
        killWM = "quit";
        killFocused = "close";
        fullScreen = "";
        floatingToggle = "";
        focusLast = "focus_last";

        bin = let
          swaylock = lib.getExe config.programs.swaylock.package;
          dunstify = lib.getExe' config.services.dunst.package "dunstify";

          quickshell = lib.getExe pkgs.quickshell;

          screenshotRegion = pkgs.writers.writeBash "screenshot-region.sh" ''
            grim -g "$(slurp)" - | wl-copy && wl-paste -n > ~/Screenshots/Screenshot-$(date +%F_%T).png | dunstify \"Screenshot of the region taken\" -t 1000
          '';
          screenshotScreen = pkgs.writers.writeBash "screenshot-region.sh" ''
            grim - | wl-copy && wl-paste -n > ~/Screenshots/Screenshot-$(date +%F_%T).png | dunstify "Screenshot of whole screen taken" -t 1000
          '';
        in {
          toggleBar = "${quickshell} ipc call main toggle bar";
          lock = "${swaylock} -c 000000 -l --ring-color 8e6e9c --key-hl-color dba8f3";
          notifyLayoutSwitch = "${dunstify} layout changed";

          inherit screenshotRegion screenshotScreen;
        };

        moveFocus = {
          up = "focus_prev";
          down = "focus_next";
          right = "focus_next";
          left = "focus_prev";
        };
        moveWindow = {
          up = "overlay_set_y -50";
          down = "overlay_set_y +50";
          right = "overlay_set_x +50";
          left = "overlay_set_x -50";
        };
        resizeWindow = {
          up = "overlay_set_height -150";
          down = "overlay_set_height +150";
          right = "overlay_set_width +150";
          left = "overlay_set_width -150";
        };
        workspace = {
          focus = num: "focus_n ${toString ((lib.toInt num) - 1)}";
          moveWindowTo = num: "focus_n ${toString ((lib.toInt num) - 1)}";
        };
      };
    };
  };
}

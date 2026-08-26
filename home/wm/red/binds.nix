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
        in {
          toggleBar = "${quickshell} ipc call main toggle bar";
          lock = "${swaylock} -c 000000 -l --ring-color 8e6e9c --key-hl-color dba8f3";
          notifyLayoutSwitch = "${dunstify} layout changed";

          screenshotRegion = "";
          screenshotScreen = "";
        };

        moveFocus = {
          up = "";
          down = "";
          right = "";
          left = "";
        };
        moveWindow = {
          up = "overlay_set_y -10";
          down = "overlay_set_y +10";
          right = "";
          left = "";
        };
        resizeWindow = {
          up = "";
          down = "";
          right = "";
          left = "";
        };
        workspace = {
          focus = num: "focus_n ${toString ((lib.toInt num) - 1)}";
          moveWindowTo = num: "focus_n ${toString ((lib.toInt num) - 1)}";
        };
      };
    };
  };
}

{
  pkgs,
  lib,
  username,
  config,
  ...
} @ attr: {
  cbinds.windowManager.leftwm.settings = {
    isLeft = true;
    isX11 = true;
    keys = {
      mod = "modkey";
      shift = "Shift";
      ctrl = "Control";
      alt = "Alt";
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

    cmds = let
      eww = lib.getExe config.programs.eww.package;
    in rec {
      exec = "Execute";
      killWM = [exec "pkill leftwm"];
      killFocused = "CloseWindow";
      fullScreen = "ToggleFullScreen";
      floatingToggle = "ToggleFloating";
      focusLast = "SwapTags";
      refreshBinds = "SoftReload";
      switchSplitOrientation = "NextLayout";

      bin = let
        i3lock = lib.getExe pkgs.i3lock;
        shutter = lib.getExe pkgs.shutter;
        kb = config.xdg.configFile."leftwm/themes/current/kb.sh".source;
      in {
        toggleBar = "${eww} -c ~/.config/leftwm/themes/current/eww open tags --toggle";
        lock = "${i3lock} -c 000000";
        notifyLayoutSwitch = "${kb}";

        screenshotRegion = "${shutter} -s";
        screenshotScreen = "${shutter} -f";
      };

      btmTrayToggle = [exec "${eww} -c ~/.config/leftwm/themes/current/eww open btm_tray --toggle"];

      downKeebBrightness = [exec "spawn 'brightnessctl -d asus::kbd_backlight set 33%-'"];
      upKeebBrightness = [exec "spawn 'brightnessctl -d asus::kbd_backlight set +33%'"];

      upMonBrightness = [exec "spawn 'sudo light -U 5 && dunstctl close && dunstify \\\"Brightness at: $(cat /sys/class/backlight/intel_backlight/brightness)\\\"'"];
      downMonBrightness = [exec "spawn 'sudo light -A 5 && dunstctl close && dunstify \\\"Brightness at: $(cat /sys/class/backlight/intel_backlight/brightness)\\\"'"];

      muteAudio = [exec "spawn 'amixer set Master toggle && dunstify \\\"Volume at: $(pamixer --get-volume-human)\\\"'"];
      muteMic = [exec "spawn 'amixer set Capture toggle && dunstify \\\"Mic at: $(pamixer --get-volume-human --default-source)\\\"'"];

      toggleKeyboardInput = [exec "${toString (import ../share/keyboardGrabber attr)}"];

      moveFocus = {
        up = "FocusWindowUp";
        down = "FocusWindowDown";
        right = "FocusWindowDown";
        left = "FocusWindowUp";
      };
      moveWindow = {
        up = "MoveWindowUp";
        down = "MoveWindowDown";
        right = "MoveWindowDown";
        left = "MoveWindowUp";
      };
      resizeWindow = {
        up = "MoveWindowUp";
        down = "MoveWindowDown";
        right = ["IncreaseMainWidth" "5"];
        left = ["DecreaseMainWidth" "5"];
      };
      workspace = {
        focus = num: ["GotoTag" "${num}"];
        moveWindowTo = num: ["MoveToTag" "${num}"];
      };
    };
  };
}

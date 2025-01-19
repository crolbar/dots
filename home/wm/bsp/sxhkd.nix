{
  lib,
  config,
  ...
}: {
  # make sure binds generator is imported
  imports = [../share/binds];

  services.sxhkd.enable = true;

  cbinds.windowManager.bsp.settings = {
    isBsp = true;
    isX11 = true;
    keys = {
      mod = "super";
      shift = "shift";
      ctrl = "ctrl";
      alt = "alt";
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
      exec = "";
      killWM = "bspc quit";
      killFocused = "bspc node -c";
      fullScreen = "bspc node -t \\~fullscreen";
      floatingToggle = "bspc node -t \\~floating";
      focusLast = "bspc node -f last";

      refreshBinds = "bspc wm -r";

      switchSplitOrientation = "bspc node @/ --rotate 90";

      bin = let
        dunstify = lib.getExe' config.services.dunst.package "dunstify";
      in {
        toggleBar = "eww -c ~/.config/bspwm/eww open bar --toggle";
        lock = "i3lock -c 000000";

        notifyLayoutSwitch = "${dunstify} layout changed";

        screenshotRegion = "shutter -s";
        screenshotScreen = "shutter -f";
      };

      moveFocus = {
        up = "bspc node -f north";
        down = "bspc node -f south";
        right = "bspc node -f east";
        left = "bspc node -f west";
      };
      moveWindow = {
        up = "bspc node -s north";
        down = "bspc node -s south";
        right = "bspc node -s east";
        left = "bspc node -s west";
      };

      resizeWindow = {
        up = "bspc node -z top 0 -50";
        down = "bspc node -z bottom 0 50";
        right = "bspc node -z right 50 0";
        left = "bspc node -z left -50 0";
      };
      workspace = {
        focus = num: "bspc desktop ${num} -f";
        moveWindowTo = num: "bspc node -d ${num}";
      };
    };
  };
}

{
  pkgs,
  lib,
  config,
  ...
}: {
  cbinds.windowManager.i3.settings = {
    isX11 = true;
    isI3 = true;
    keys = {
      mod = config.xsession.windowManager.i3.config.modifier;
      shift = "Shift";
      ctrl = "Control";
      alt = "Mod1";
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
      exec = "exec";
      killWM = "exit";
      killFocused = "kill";
      fullScreen = "fullscreen toggle";
      floatingToggle = "floating toggle";
      focusLast = "focus next"; # no alt tab in i3..
      refreshBinds = "reload";
      switchSplitOrientation = "layout toggle split";
      switchLayoutTabbed = "layout tabbed";

      bin = let
        i3lock = lib.getExe pkgs.i3lock;
        shutter = lib.getExe pkgs.shutter;
        kb = config.xdg.configFile."i3/kbi3.sh".source;
        i3-msg = lib.getExe' config.xsession.windowManager.i3.package "i3-msg";
      in {
        toggleBar = "${i3-msg} bar mode toggle";
        lock = "${i3lock} -c 000000";
        notifyLayoutSwitch = "${kb}";

        screenshotRegion = "${shutter} -s";
        screenshotScreen = "${shutter} -f";
      };

      moveFocus = {
        up = "focus up";
        down = "focus down";
        right = "focus right";
        left = "focus left";
      };
      moveWindow = {
        up = "move up";
        down = "move down";
        right = "move right";
        left = "move left";
      };
      resizeWindow = {
        up = "resize grow height 50px";
        down = "resize shrink height 50px";
        right = "resize grow width 50px";
        left = "resize shrink width 50px";
      };
      workspace = {
        focus = num: "workspace number ${num}";
        moveWindowTo = num: "move container to workspace number ${num}";
      };
    };
  };
}

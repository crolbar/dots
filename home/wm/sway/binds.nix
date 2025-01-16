{
  config,
  clib,
  ...
} @ attrs: let
  genBindsSettings = {
    wm = "sway";

    settings = {
      keys = {
        mod = config.wayland.windowManager.sway.config.modifier;
        shift = "Shift";
        ctrl = "Ctrl";
        alt = "Alt";
        media = {
          play = "XF86AudioPlay";
          next = "XF86AudioNext";
          prev = "XF86AudioPrev";
          lowerVolume = "XF86AudioLowerVolume";
          raiseVolume = "XF86AudioRaiseVolume";
        };
      };

      cmds = {
        fullScreen = "fullscreen toggle";
        exec = "exec";
        killFocused = "kill";
        floatingToggle = "floating toggle";
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
          up = "resize grow height 20px";
          down = "resize shrink height 20px";
          right = "resize grow width 20px";
          left = "resize shrink width 20px";
        };
        workspace = {
          focus = num: "workspace number ${num}";
          moveWindowTo = num: "move container to workspace number ${num}";
        };
      };
    };
  };
in
  clib.genBinds (genBindsSettings // attrs)

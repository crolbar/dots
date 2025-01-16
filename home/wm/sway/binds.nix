{
  config,
  lib,
  pkgs,
  clib,
  ...
} @ attrs: let
  mod = config.wayland.windowManager.sway.config.modifier;

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
      };
    };
  };
in
  clib.genBinds (genBindsSettings // attrs)
  // {
    "${mod}+grave" = "workspace number 0";
    "${mod}+1" = "workspace number 1";
    "${mod}+2" = "workspace number 2";
    "${mod}+3" = "workspace number 3";
    "${mod}+4" = "workspace number 4";
    "${mod}+5" = "workspace number 5";
    "${mod}+6" = "workspace number 6";
    "${mod}+7" = "workspace number 7";
    "${mod}+8" = "workspace number 8";
    "${mod}+9" = "workspace number 9";
    "${mod}+0" = "workspace number 10";

    "${mod}+Shift+grave" = "move container to workspace number 0";
    "${mod}+Shift+1" = "move container to workspace number 1";
    "${mod}+Shift+2" = "move container to workspace number 2";
    "${mod}+Shift+3" = "move container to workspace number 3";
    "${mod}+Shift+4" = "move container to workspace number 4";
    "${mod}+Shift+5" = "move container to workspace number 5";
    "${mod}+Shift+6" = "move container to workspace number 6";
    "${mod}+Shift+7" = "move container to workspace number 7";
    "${mod}+Shift+8" = "move container to workspace number 8";
    "${mod}+Shift+9" = "move container to workspace number 9";
    "${mod}+Shift+0" = "move container to workspace number 10";
  }

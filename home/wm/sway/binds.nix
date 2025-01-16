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

    XF86AudioPlay = "exec ${lib.getExe pkgs.playerctl} play-pause";
    XF86AudioNext = "exec ${lib.getExe pkgs.playerctl} next";
    XF86AudioPrev = "exec ${lib.getExe pkgs.playerctl} previous";

    XF86AudioLowerVolume = "exec pamixer -d 5";
    XF86AudioRaiseVolume = "exec pamixer -i 5";

    "${mod}+Shift+Alt+F11" = "exec ~/.config/hypr/scripts/volume.sh music-";
    "${mod}+Shift+Alt+F12" = "exec ~/.config/hypr/scripts/volume.sh music+";
    "${mod}+Shift+Alt+F7" = "exec ~/scripts/eww/volume.sh music mute";
    "${mod}+Shift+Alt+F9" = "exec ~/.config/hypr/scripts/volume.sh browser-";
    "${mod}+Shift+Alt+F10" = "exec ~/.config/hypr/scripts/volume.sh browser+";
    "${mod}+Shift+Alt+F8" = "exec ~/scripts/eww/volume.sh browser mute";

    #"${mod}+x" = "exec ${lib.getExe pkgs.foot}";
    #"${mod}+f" = "fullscreen toggle";
    #"${mod}+r" = "exec ${lib.getExe pkgs.anyrun}";
    #"${mod}+Shift+q" = "kill";
    #"${mod}+z" = "floating toggle";
    #"${mod}+h" = "focus left";
    #"${mod}+j" = "focus down";
    #"${mod}+k" = "focus up";
    #"${mod}+l" = "focus right";
    #"${mod}+Ctrl+h" = "move left";
    #"${mod}+Ctrl+j" = "move down";
    #"${mod}+Ctrl+k" = "move up";
    #"${mod}+Ctrl+l" = "move right";
  }
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

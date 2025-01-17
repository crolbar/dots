{
  wayland.windowManager.hyprland.settings = {
    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];
  };

  cbinds.windowManager.hypr.settings = {
    keys = {
      mod = "SUPER";
      shift = "SHIFT";
      ctrl = "CTRL";
      alt = "ALT";
      print = "Print";
      media = {
        play = "XF86AudioPlay";
        next = "XF86AudioNext";
        prev = "XF86AudioPrev";
        lowerVolume = "XF86AudioLowerVolume";
        raiseVolume = "XF86AudioRaiseVolume";
      };
    };

    cmds = {
      fullScreen = "fullscreen";
      exec = "exec,";
      killFocused = "killactive";
      floatingToggle = "togglefloating";
      switchSplitOrientation = "togglesplit"; # OPTIONAL SETTING
      focusLast = "focuscurrentorlast";
      toggleBar = "eww -c ~/.config/hypr/eww/ open bar --toggle";
      killWM = "exit";
      lock = "swaylock -c 000000 -l --ring-color 8e6e9c --key-hl-color dba8f3";
      screenshotRegion = ''grim -g "$(slurp)" - | wl-copy && wl-paste -n > ~/Screenshots/Screenshot-$(date +%F_%T).png | dunstify "Screenshot of the region taken" -t 1000'';
      screenshotScreen = ''grim - | wl-copy && wl-paste > ~/Screenshots/Screenshot-$(date +%F_%T).png | dunstify "Screenshot of whole screen taken" -t 1000'';
      notifyLayoutSwitch = ''dunstify layout "Changed to: $(hyprctl devices -j | jq '.keyboards[] | select(.name == "crolbar-yuki") | .active_keymap')"'';
      moveFocus = {
        up = "movefocus, u";
        down = "movefocus, d";
        right = "movefocus, r";
        left = "movefocus, l";
      };
      moveWindow = {
        up = "movewindow, u";
        down = "movewindow, d";
        right = "movewindow, r";
        left = "movewindow, l";
      };
      resizeWindow = {
        up = "resizeactive,0 -70";
        down = "resizeactive,0 70";
        right = "resizeactive,70 0";
        left = "resizeactive,-70 0";
      };

      workspace = {
        focus = num:
          if num == "0"
          then "workspace, name:0"
          else "exec, ~/.config/hypr/scripts/dispatch ${num} f";
        moveWindowTo = num:
          if num == "0"
          then "movetoworkspacesilent, name:0"
          else "exec, ~/.config/hypr/scripts/dispatch ${num} s";
      };
    };
  };
}

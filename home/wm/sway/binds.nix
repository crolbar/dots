{config, ...}: {
  # make sure binds generator is imported
  imports = [../share/binds];

  cbinds.windowManager.sway.settings = {
    keys = {
      mod = config.wayland.windowManager.sway.config.modifier;
      shift = "Shift";
      ctrl = "Ctrl";
      alt = "Alt";
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
      exec = "exec";
      killWM = "exit";
      killFocused = "kill";
      fullScreen = "fullscreen toggle";
      floatingToggle = "floating toggle";
      focusLast = "focus next"; # no alt tab in sway..

      toggleBar = "swaymsg bar bar-0 mode toggle";
      notifyLayoutSwitch = ''dunstify layout "Changed to: $(swaymsg -t get_inputs | jq -r '.[] | select(.type == "keyboard" and .name == "crolbar YUKI") | .xkb_active_layout_name')"'';
      lock = "swaylock -c 000000 -l --ring-color 8e6e9c --key-hl-color dba8f3";

      screenshotRegion = ''grim -g "$(slurp)" - | wl-copy && wl-paste -n > ~/Screenshots/Screenshot-$(date +%F_%T).png | dunstify "Screenshot of the region taken" -t 1000'';
      screenshotScreen = ''grim - | wl-copy && wl-paste > ~/Screenshots/Screenshot-$(date +%F_%T).png | dunstify "Screenshot of whole screen taken" -t 1000'';

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
}

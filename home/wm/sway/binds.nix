{
  clib,
  lib,
  pkgs,
  config,
  ...
}: {
  # make sure binds generator is imported
  imports = [../share/binds];

  cbinds.windowManager.sway.settings = {
    keys = {
      mod = config.wayland.windowManager.sway.config.modifier;
      shift = "Shift";
      ctrl = "Ctrl";
      alt = "Alt";
      print = "Print";
      tab = "TAB";
      space = "Space";
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

      bin = let
        swaymsg = lib.getExe' config.wayland.windowManager.sway.package "swaymsg";
        swaylock = lib.getExe config.programs.swaylock.package;
        dunstify = lib.getExe' config.services.dunst.package "dunstify";
        jq = lib.getExe pkgs.jq;
        grim = lib.getExe pkgs.grim;
        slurp = lib.getExe pkgs.slurp;
        wl-copy = lib.getExe' pkgs.wl-clipboard "wl-copy";
        wl-paste = lib.getExe' pkgs.wl-clipboard "wl-paste";
      in {
        toggleBar = "${swaymsg} bar bar-0 mode toggle";
        lock = "${swaylock} -c 000000 -l --ring-color 8e6e9c --key-hl-color dba8f3";
        notifyLayoutSwitch = clib.mk1lnrCmd ''
          ${dunstify} layout "Changed to: $(${swaymsg} -t get_inputs | \
          ${jq} -r '.[] | select(.type == "keyboard" and .name == "crolbar YUKI") | .xkb_active_layout_name')"
        '';

        screenshotRegion = clib.mk1lnrCmd ''
          ${grim} -g "$(${slurp})" - | \
          ${wl-copy} && \
          ${wl-paste} -n > ~/Screenshots/Screenshot-$(date +%F_%T).png | \
          ${dunstify} "Screenshot of the region taken" -t 1000
        '';
        screenshotScreen = clib.mk1lnrCmd ''
          ${grim} - | \
          ${wl-copy} && \
          ${wl-paste} > ~/Screenshots/Screenshot-$(date +%F_%T).png | \
          ${dunstify} "Screenshot of whole screen taken" -t 1000
        '';
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

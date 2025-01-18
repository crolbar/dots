{
  clib,
  lib,
  pkgs,
  config,
  ...
}: {
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
      killWM = "exit";
      exec = "exec,";
      fullScreen = "fullscreen";
      killFocused = "killactive";
      floatingToggle = "togglefloating";
      focusLast = "focuscurrentorlast";

      switchSplitOrientation = "togglesplit"; # OPTIONAL SETTING

      bin = let
        eww = lib.getExe config.programs.eww.package;
        swaylock = lib.getExe config.programs.swaylock.package;
        dunstify = lib.getExe' config.services.dunst.package "dunstify";
        hyprctl = lib.getExe' config.wayland.windowManager.hyprland.package "hyprctl";
        jq = lib.getExe pkgs.jq;
        grim = lib.getExe pkgs.grim;
        slurp = lib.getExe pkgs.slurp;
        wl-copy = lib.getExe' pkgs.wl-clipboard "wl-copy";
        wl-paste = lib.getExe' pkgs.wl-clipboard "wl-paste";
      in {
        toggleBar = "${eww} -c ~/.config/hypr/eww/ open bar --toggle";
        lock = "${swaylock} -c 000000 -l --ring-color 8e6e9c --key-hl-color dba8f3";
        notifyLayoutSwitch = clib.mk1lnrCmd ''
          ${dunstify} layout "Changed to: $(${hyprctl} devices -j | \
          ${jq} '.keyboards[] | select(.name == "crolbar-yuki") | .active_keymap')"
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

      workspace = let
        dispatch = config.xdg.configFile."hypr/scripts/dispatch".source;
      in {
        focus = num:
          if num == "0"
          then "workspace, name:0"
          else "exec, ${dispatch} ${num} f";
        moveWindowTo = num:
          if num == "0"
          then "movetoworkspacesilent, name:0"
          else "exec, ${dispatch} ${num} s";
      };
    };
  };
}

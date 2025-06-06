{
  clib,
  lib,
  pkgs,
  config,
  username,
  ...
} @ attr: let
  keebName = "AT Translated Set 2 keyboard";
  keyboardGrabber = import ./keyboardGrabber.nix ({inherit keebName;} // attr);
  stray = lib.getExe' pkgs.stray "stray";
  keyboardToggler = pkgs.writers.writeBash "keyboardToggler-niri" ''
    if pgrep -f "keyboardGrabber" > /dev/null; then
        sudo pkill -f "keyboardGrabber"
        kill $(cat /tmp/stray-keyboardToggler-niri.pid)
        dunstify "keyboard ungrabbed"
    else
        sudo ${keyboardGrabber} &
        ${stray} --add-item "enable keeb" "sudo pkill -f keyboardGrabber && kill $(cat /tmp/stray-keyboardToggler-niri.pid)" --name keyboardToggler-niri --icon /home/${username}/keyboardToggler.png &
        dunstify "keyboard grabbed"
    fi
  '';
in {
  imports = [../share/binds];

  cbinds.windowManager.niri.settings = {
    isNiri = true;
    keys = {
      mod = "Super";
      shift = "Shift";
      ctrl = "Ctrl";
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
      exec = "spawn";
      sh = cmd: [exec ["sh" "-c" cmd]];
    in {
      inherit exec;
      killWM = "quit";
      killFocused = "close-window";
      fullScreen = "fullscreen-window";
      floatingToggle = "toggle-window-floating";
      focusLast = "focus-window-previous";

      bin = let
        eww = lib.getExe config.programs.eww.package;
        swaylock = lib.getExe config.programs.swaylock.package;
        dunstify = lib.getExe' config.services.dunst.package "dunstify";
        grim = lib.getExe pkgs.grim;
        slurp = lib.getExe pkgs.slurp;
        wl-copy = lib.getExe' pkgs.wl-clipboard "wl-copy";
        wl-paste = lib.getExe' pkgs.wl-clipboard "wl-paste";
      in {
        toggleBar = "${eww} -c ~/.config/niri/eww open tags --toggle";
        lock = "${swaylock} -c 000000 -l --ring-color 8e6e9c --key-hl-color dba8f3";
        notifyLayoutSwitch = "${dunstify} layout changed";

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

      focusNextOutput = "focus-monitor-next";
      focusPrevOutput = "focus-monitor-previous";

      moveToNextOutput = "move-window-to-monitor-next";
      moveToPrevOutput = "move-window-to-monitor-previous";

      btmTrayToggle = sh "eww -c ~/.config/niri/eww open btm_tray --toggle";

      upMonBrightness = sh "sudo light -U 5 && dunstctl close && dunstify \"Brightness at: $(cat /sys/class/backlight/intel_backlight/brightness)\"";
      downMonBrightness = sh "sudo light -A 5 && dunstctl close && dunstify \"Brightness at: $(cat /sys/class/backlight/intel_backlight/brightness)\"";

      downKeebBrightness = sh "brightnessctl -d asus::kbd_backlight set 33%-";
      upKeebBrightness = sh "brightnessctl -d asus::kbd_backlight set +33%";

      muteAudio = sh "amixer set Master toggle && dunstify \"Volume at: $(pamixer --get-volume-human)\"";
      muteMic = sh "amixer set Capture toggle && dunstify \"Mic at: $(pamixer --get-volume-human --default-source)\"";

      # monoclce/tabbed
      switchLayoutMonocle = "toggle-column-tabbed-display";

      maximize = "maximize-column";

      centerCol = "center-column";

      floatingFocusToggle = "switch-focus-between-floating-and-tiling";

      addWindowToTab = "consume-window-into-column";
      removeWindowFromTab = "expel-window-from-column";

      toggleKeyboardInput = sh "${toString keyboardToggler}";

      moveFocus = {
        up = "focus-window-or-workspace-up";
        down = "focus-window-or-workspace-down";
        right = "focus-column-right";
        left = "focus-column-left";
      };
      moveWindow = {
        up = "move-window-up-or-to-workspace-up";
        down = "move-window-down-or-to-workspace-down";
        right = "move-column-right";
        left = "move-column-left";
      };
      resizeWindow = {
        up = ["set-window-height" "-10%"];
        down = ["set-window-height" "+10%"];
        right = ["set-window-width" "+10%"];
        left = ["set-window-width" "-10%"];
      };
      workspace = {
        focus = num: ["focus-workspace" num];
        moveWindowTo = num: ["move-window-to-workspace" num];
      };
    };
  };
}

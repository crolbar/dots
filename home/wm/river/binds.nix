{
  clib,
  lib,
  pkgs,
  config,
  username,
  ...
}: let
  keyboardToggler = (clib.writers pkgs).writeGo "keyboardToggler" ''
    package main

    import (
        "os/exec"
        "strings"
    )

    func main() {
        out, err := exec.Command("riverctl", "list-input-configs").Output()
        if err != nil {
            return
        }
        outStr := string(out)
        name := "keyboard-1-1-AT_Translated_Set_2_keyboard"

        sp := strings.Index(outStr, name)

        sp += len(name)+1

        ep := strings.Index(outStr[sp:], "\n")

        status := strings.TrimSpace(outStr[sp:sp+ep])

        switch status {
        case "events: disabled":
            exec.Command("riverctl", "input", "keyboard-1-1-AT_Translated_Set_2_keyboard", "events", "enabled").Run()
            exec.Command("sh", "-c", "kill $(cat /tmp/stray-keyboardToggler.pid)").Run()
        case "events: enabled":
            fallthrough
        default:
            exec.Command("riverctl", "input", "keyboard-1-1-AT_Translated_Set_2_keyboard", "events", "disabled").Run()
            exec.Command("stray",
                "--add-item",
                "enable keeb",
                "riverctl input keyboard-1-1-AT_Translated_Set_2_keyboard events enabled && kill $(cat /tmp/stray-keyboardToggler.pid)",
                "--name",
                "keyboardToggler",
                "--icon",
                "/home/${username}/keyboardToggler.png",
            ).Run()
        }
    }
  '';
in {
  # make sure binds generator is imported
  imports = [../share/binds];

  wayland.windowManager.river.settings = {
    map-pointer.normal = {
      "Super BTN_LEFT" = "move-view";
      "Super BTN_RIGHT" = "resize-view";
    };
  };

  cbinds.windowManager.river.settings = {
    keys = {
      mod = "Super";
      shift = "Shift";
      ctrl = "Control";
      alt = "Alt";
      print = "PRINT";
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
      exec = "spawn";
      killWM = "exit";
      killFocused = "close";
      fullScreen = "toggle-fullscreen";
      floatingToggle = "toggle-float";
      focusLast = "focus-view next"; # no alt tab in river..

      bin = let
        eww = lib.getExe config.programs.eww.package;
        swaylock = lib.getExe config.programs.swaylock.package;
        dunstify = lib.getExe' config.services.dunst.package "dunstify";
        grim = lib.getExe pkgs.grim;
        slurp = lib.getExe pkgs.slurp;
        wl-copy = lib.getExe' pkgs.wl-clipboard "wl-copy";
        wl-paste = lib.getExe' pkgs.wl-clipboard "wl-paste";
      in {
        toggleBar = "${eww} -c ~/.config/river/eww open tags --toggle";
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

      increaseMasterWindows = "send-layout-cmd wideriver '--count +1'";
      decreaseMasterWindows = "send-layout-cmd wideriver '--count -1'";

      moveMasterTop = "send-layout-cmd wideriver '--layout top'";
      moveMasterBottom = "send-layout-cmd wideriver '--layout bottom'";
      moveMasterRight = "send-layout-cmd wideriver '--layout right'";
      moveMasterLeft = "send-layout-cmd wideriver '--layout left'";

      switchLayoutMonocle = "send-layout-cmd wideriver '--layout monocle'";

      resizeFloatUp = "resize vertical -100";
      resizeFloatDown = "resize vertical 100";
      resizeFloatRight = "resize horizontal 100";
      resizeFloatLeft = "resize horizontal -100";

      focusNextOutput = "focus-output next";
      focusPrevOutput = "focus-output previous";

      moveToNextOutput = "send-to-output next";
      moveToPrevOutput = "send-to-output previous";

      btmTrayToggle = "spawn 'eww -c ~/.config/river/eww open btm_tray --toggle'";

      upMonBrightness = "spawn 'sudo light -U 5 && dunstctl close && dunstify \"Brightness at: $(cat /sys/class/backlight/intel_backlight/brightness)\"'";
      downMonBrightness = "spawn 'sudo light -A 5 && dunstctl close && dunstify \"Brightness at: $(cat /sys/class/backlight/intel_backlight/brightness)\"'";

      downKeebBrightness = "spawn 'brightnessctl -d asus::kbd_backlight set 33%-'";
      upKeebBrightness = "spawn 'brightnessctl -d asus::kbd_backlight set +33%'";

      muteAudio = "spawn 'amixer set Master toggle && dunstify \"Volume at: $(pamixer --get-volume-human)\"'";
      muteMic = "spawn 'amixer set Capture toggle && dunstify \"Mic at: $(pamixer --get-volume-human --default-source)\"'";

      toggleKeyboardInput = "spawn '${toString keyboardToggler}'";

      moveFocus = {
        up = "focus-view previous";
        down = "focus-view next";
        right = "focus-view previous";
        left = "focus-view next";
      };
      moveWindow = {
        up = "move up 100";
        down = "move down 100";
        right = "move right 100";
        left = "move left 100";
      };
      resizeWindow = {
        up = "swap previous"; # not resize but im used to this
        down = "swap next";
        right = "send-layout-cmd wideriver '--ratio +0.05'";
        left = "send-layout-cmd wideriver '--ratio -0.05'";
      };
      workspace = let
        getPOT = n:
          if n <= 0
          then 1
          else 2 * (getPOT (n - 1));
      in {
        focus = num: "set-focused-tags ${toString (getPOT ((lib.toInt num) - 1))}";
        moveWindowTo = num: "set-view-tags ${toString (getPOT ((lib.toInt num) - 1))}";
      };
    };
  };
}

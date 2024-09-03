{lib, ...}: let
  op = n:
    if n == 0
    then 1
    else 2 * (op (n - 1));

  tagBinds = lib.listToAttrs (
    lib.concatMap (
      i: let
        index = toString i;
        tag = toString (op (i - 1));
      in [
        {
          name = "Super " + index;
          value = "set-focused-tags" + " " + tag;
        }
        {
          name = "Super+Shift " + index;
          value = "set-view-tags" + " " + tag;
        }
      ]
    ) (builtins.genList (i: i + 1) 10)
  );
in {
  wayland.windowManager.river.settings = {
    map.normal =
      tagBinds
      // {
        # Super Shift Alt Control
        "Super x" = "spawn alacritty";
        "Super+Shift X" = "spawn foot";
        "Super b" = "spawn schizofox";
        "Super m" = "spawn spotify";
        "Super r" = "spawn anyrun";

        # Window control
        "Super+Shift Q" = "close";
        "Super z" = "toggle-float";
        "Super f" = "toggle-fullscreen";

        "Super j" = "focus-view next";
        "Super k" = "focus-view previous";
        "Super h" = "focus-view next";
        "Super l" = "focus-view previous";

        "Super+Shift J" = "swap next";
        "Super+Shift K" = "swap previous";

        "Super+Shift H" = "send-layout-cmd wideriver '--ratio -0.05'";
        "Super+Shift L" = "send-layout-cmd wideriver '--ratio +0.05'";

        "Super n" = "send-layout-cmd wideriver '--count -1'";
        "Super+Shift n" = "send-layout-cmd wideriver '--count +1'";

        "Super Up" = "send-layout-cmd wideriver '--layout top'";
        "Super Right" = "send-layout-cmd wideriver '--layout right'";
        "Super Down" = "send-layout-cmd wideriver '--layout bottom'";
        "Super Left" = "send-layout-cmd wideriver '--layout left'";


        # Floats
        "Super+Control H" = "move left 100";
        "Super+Control J" = "move down 100";
        "Super+Control K" = "move up 100";
        "Super+Control L" = "move right 100";

        "Super+Control+Shift H" = "resize horizontal -100";
        "Super+Control+Shift J" = "resize vertical 100";
        "Super+Control+Shift K" = "resize vertical -100";
        "Super+Control+Shift L" = "resize horizontal 100";

        # Output
        "Super Period" = "focus-output next";
        "Super Comma" = "focus-output previous";

        "Super+Shift Period" = "send-to-output next";
        "Super+Shift Comma" = "send-to-output previous";


        # EWW
        "Super s" = "spawn \"eww open board --toggle\"";
        "Super p" = "spawn \"eww -c ~/.config/river/eww open btm_tray --toggle\"";
        "Super w" = "spawn \"eww -c ~/.config/river/eww open tags --toggle\"";
        "Super+Shift s" = "spawn \"pkill eww\"";

        # Wall
        "Super a" = "spawn \"~/scripts/wall.sh f\"";
        "Super+Shift a" = "spawn \"~/scripts/wall.sh b\"";
        "Super+ALT a" = "spawn \"~/scripts/wall.sh f f\"";
        "Super+Shift+Alt A" = "spawn \"~/scripts/wall.sh b f\"";
        "Super c" = "spawn \"swww clear\"";

        # MEDIA & LIGHT
        "None XF86MonBrightnessDown" = "spawn 'sudo light -U 5 && dunstctl close && dunstify \"Brightness at: $(cat /sys/class/backlight/intel_backlight/brightness)\"'";
        "None XF86MonBrightnessUp" = "spawn 'sudo light -A 5 && dunstctl close && dunstify \"Brightness at: $(cat /sys/class/backlight/intel_backlight/brightness)\"'";

        "Super F2" = "spawn \"brightnessctl -d asus::kbd_backlight set 33%-\"";
        "Super F3" = "spawn \"brightnessctl -d asus::kbd_backlight set +33%\"";

        "None XF86AudioLowerVolume" = "spawn 'amixer set Master 5%- && dunstctl close-all && dunstify \"Volume at: $(pamixer --get-volume-human)\"'";
        "None XF86AudioRaiseVolume" = "spawn 'amixer set Master 5%+ && dunstctl close-all && dunstify \"Volume at: $(pamixer --get-volume-human)\"'";
        "None XF86AudioMute" = "spawn 'amixer set Master toggle && dunstify \"Volume at: $(pamixer --get-volume-human)\"'";
        "None XF86AudioMicMute" = "spawn 'amixer set Capture toggle && dunstify \"Mic at: $(pamixer --get-volume-human --default-source)\"'";

        # MISC
        "Super+Shift+Alt+Control q" = "exit";
        "Super+Shift+Alt+Control l" = "spawn \"swaylock -c 000000 -l --ring-color 8e6e9c --key-hl-color dba8f3\"";
        "Super+Shift+Alt+Control s" = "spawn \"sudo systemctl suspend && swaylock -c 000000 -l --ring-color 8e6e9c --key-hl-color dba8f3\"";

        "None PRINT" = "spawn 'grim -g \"$(slurp)\" - | wl-copy && wl-paste -n > ~/Screenshots/Screenshot-$(date +%F_%T).png | dunstify \"Screenshot of the region taken\" -t 1000 # screenshot of a region'";
        "Shift PRINT" = "spawn 'grim - | wl-copy && wl-paste > ~/Screenshots/Screenshot-$(date +%F_%T).png | dunstify \"Screenshot of whole screen taken\" -t 1000 # screenshot of the whole screen'";

      };

    map-pointer.normal = {
      "Super BTN_LEFT" = "move-view";
      "Super BTN_RIGHT" = "resize-view";
    };
  };
}

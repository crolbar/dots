{
  wayland.windowManager.hyprland.settings = {
    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];
    bind = [
      # app binds
      "SUPER, x, exec, alacritty"
      "SUPER SHIFT, x, exec, foot"
      "SUPER, b, exec, schizofox"
      "SUPER, m, exec, spotify"
      "SUPER, r, exec, anyrun"

      # EWW
      "SUPER, s, exec, eww open board --toggle"
      "SUPER SHIFT, d, exec, eww open set_board --toggle"
      "SUPER, d, exec, eww open player-info --toggle"
      "SUPER, w, exec, eww -c ~/.config/hypr/eww/ open bar --toggle"
      "SUPER SHIFT, s, exec, pkill eww"

      # wallpaper changer
      "SUPER, a, exec, ~/scripts/wall.sh f"
      "SUPER SHIFT, a, exec, ~/scripts/wall.sh b"
      "SUPER ALT, a, exec, ~/scripts/wall.sh f f"
      "SUPER SHIFT ALT, a, exec, ~/scripts/wall.sh b f"
      "SUPER, c, exec, swww clear"

      # VM
      "SUPER ALT CTRL, v, exec, virt-viewer -f -c qemu:///system win10 | sudo virsh start win10 "
      "SUPER ALT CTRL SHIFT, v, exec, sudo virsh shutdown win10 "

      # switch to next rgb profile
      "SUPER CTRL, a, exec, ~/.config/hypr/scripts/rgb"
      # open KeyboardVisualizer and start openrgb server
      "SUPER CTRL SHIFT, a, exec, ~/.config/hypr/scripts/rgb s"
      # stop openrgb and turn off lights
      "SUPER CTRL ALT, a, exec, openrgb -p black"

      # window control
      "SUPER SHIFT, q, killactive"
      "SUPER, z, togglefloating"
      "SUPER, f, fullscreen"
      "SUPER SHIFT, r, togglesplit"
      "SUPER SHIFT, p, togglesplit"

      # move focus
      "SUPER, left, movefocus, l"
      "SUPER, right, movefocus, r"
      "SUPER, up, movefocus, u"
      "SUPER, down, movefocus, d"
      "SUPER, l, movefocus, r"
      "SUPER, h, movefocus, l"
      "SUPER, k, movefocus, u"
      "SUPER, j, movefocus, d"
      "SUPER SHIFT, l, resizeactive,70 0"
      "SUPER SHIFT, h, resizeactive,-70 0"
      "SUPER SHIFT, k, resizeactive,0 -70"
      "SUPER SHIFT, j, resizeactive,0 70"
      "ALT, TAB, focuscurrentorlast"

      # switch workspaces
      "SUPER, grave, workspace, name:0"
      "SUPER, 1, exec, ~/.config/hypr/scripts/dispatch.c 1 f"
      "SUPER, 2, exec, ~/.config/hypr/scripts/dispatch.c 2 f"
      "SUPER, 3, exec, ~/.config/hypr/scripts/dispatch.c 3 f"
      "SUPER, 4, exec, ~/.config/hypr/scripts/dispatch.c 4 f"
      "SUPER, 5, exec, ~/.config/hypr/scripts/dispatch.c 5 f"
      "SUPER, 6, exec, ~/.config/hypr/scripts/dispatch.c 6 f"
      "SUPER, 7, exec, ~/.config/hypr/scripts/dispatch.c 7 f"
      "SUPER, 8, exec, ~/.config/hypr/scripts/dispatch.c 8 f"
      "SUPER, 9, exec, ~/.config/hypr/scripts/dispatch.c 9 f"
      "SUPER, 0, exec, ~/.config/hypr/scripts/dispatch.c 10 f"

      # move focused window to a workspace
      "SUPER SHIFT, grave, movetoworkspacesilent, name:0"
      "SUPER SHIFT, 1, exec, ~/.config/hypr/scripts/dispatch.c 1 s"
      "SUPER SHIFT, 2, exec, ~/.config/hypr/scripts/dispatch.c 2 s"
      "SUPER SHIFT, 3, exec, ~/.config/hypr/scripts/dispatch.c 3 s"
      "SUPER SHIFT, 4, exec, ~/.config/hypr/scripts/dispatch.c 4 s"
      "SUPER SHIFT, 5, exec, ~/.config/hypr/scripts/dispatch.c 5 s"
      "SUPER SHIFT, 6, exec, ~/.config/hypr/scripts/dispatch.c 6 s"
      "SUPER SHIFT, 7, exec, ~/.config/hypr/scripts/dispatch.c 7 s"
      "SUPER SHIFT, 8, exec, ~/.config/hypr/scripts/dispatch.c 8 s"
      "SUPER SHIFT, 9, exec, ~/.config/hypr/scripts/dispatch.c 9 s"
      "SUPER SHIFT, 0, exec, ~/.config/hypr/scripts/dispatch.c 10 s"

      # lock, poweroff, reboot, sleep, exit
      "SUPER SHIFT ALT CTRL, l, exec, swaylock -c 000000 -l --ring-color 8e6e9c --key-hl-color dba8f3 &"
      "SUPER SHIFT ALT CTRL, p, exec, sudo poweroff"
      "SUPER SHIFT ALT CTRL, r, exec, sudo reboot"
      "SUPER SHIFT ALT CTRL, s, exec, swaylock -c 000000 -l --ring-color 8e6e9c --key-hl-color dba8f3 & systemctl suspend &"
      "SUPER SHIFT ALT CTRL, q, exit, "

      # media
      ", XF86AudioLowerVolume, exec, pamixer -d 5"
      ", XF86AudioRaiseVolume, exec, pamixer -i 5"
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPlay, exec, playerctl play-pause"

      # button box binds
      "SUPER SHIFT ALT, F11, exec, ~/.config/hypr/scripts/volume.sh music-"
      "SUPER SHIFT ALT, F12, exec, ~/.config/hypr/scripts/volume.sh music+"
      "SUPER SHIFT ALT, F7, exec, ~/.config/eww/scripts/volume.sh music mute"

      "SUPER SHIFT ALT, F9, exec, ~/.config/hypr/scripts/volume.sh browser-"
      "SUPER SHIFT ALT, F10, exec, ~/.config/hypr/scripts/volume.sh browser+"
      "SUPER SHIFT ALT, F8, exec, ~/.config/eww/scripts/volume.sh browser mute"

      "SUPER ALT, F9, exec, pamixer -d 5"
      "SUPER ALT, F10, exec, pamixer -i 5"
      "SUPER ALT, F8, exec, pamixer -t"

      "SUPER SHIFT, F12, exec, ~/.config/hypr/scripts/default-sink.sh"

      "SUPER ALT, q, exec, pgrep \"pavucontrol\" > /dev/null && pkill pavucontrol || pavucontrol &"
      "SUPER, F8, exec, pamixer --default-source -t"

      # screenshot
      ", Print, exec, grim -g \"$(slurp)\" - | wl-copy && wl-paste -n > ~/Screenshots/Screenshot-$(date +%F_%T).png | dunstify \"Screenshot of the region taken\" -t 1000 # screenshot of a region "
      "SHIFT, Print, exec, grim - | wl-copy && wl-paste > ~/Screenshots/Screenshot-$(date +%F_%T).png | dunstify \"Screenshot of whole screen taken\" -t 1000 # screenshot of the whole screen"
    ];
  };
}

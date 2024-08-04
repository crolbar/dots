{
  services.sxhkd = {
    enable = true;

    keybindings = {
      "super + x" = "alacritty";
      "super + r" = "rofi -show drun -show-icons";
      "super + e" = "thunar";
      "super + b" = "schizofox";
      "super + t" = "dmenu_run -nb black -sb '#6600CC'";
      "super + s" = "eww open board --toggle";
      "super + m" = "spotify";

      # restart bspwm
      "super + ctrl + r" = "bspc wm -r";

      # close window & rotate
      "super + shift +  {q,r}" = "bspc node {-c,@/ --rotate 90}";

      # set the window state
      "super + {d,z,f}" = "bspc node -t {tiled,floating,fullscreen}";

      # focus,switch the node in the given direction
      "super + {_,shift+ }{Left,Down,Up,Right}" = "bspc node -{f,s} {west,south,north,east}";

      # focus,switch the node in the give direction(vim)
      "super + {_,shift+ }{h,j,k,l}" = "bspc node -{f,s} {west,south,north,east}";

      # focus the last desktop,node and switch between tiled/monocle
      "{super,alt} + {Tab,a}" = "bspc {desktop,node} {-f last,-l next}";

      # preselect spawn direction
      "super + ctrl + {a,s,w,d,space}" = "bspc node -p {west,south,north,east,cancel} ";

      # power off,reboot,log out,lock
      "super + ctrl + alt + shift + {p,r,q,s,l}" = "{sudo systemctl poweroff,sudo systemctl reboot,bspc quit,sudo systemctl suspend,physlock -d}";

      # screenshot
      "Print" = "flameshot gui";

      # mute mic
      "super + F8" = "mic-mute --mute";

      # switch default output
      "super + shift + F12" = "DS --ds";

      # open pavucontrol
      "super + alt + {s,q}" = "{bspc rule -a \* -o state=floating && pavucontrol,pkill pavucontrol}";

      # volume control
      "super + alt + {F11,F12}" = "pamixer --allow-boost --set-limit 150 -{d,i} 3";
      "super + alt + shift + {F9,F10}" = "volume{ --browser-, --browser+}";
      "super + alt + shift + {F11,F12}" = "volume{ --music-, --music+}";

      "{XF86AudioLowerVolume,XF86AudioRaiseVolume,XF86AudioPrev,XF86AudioNext,XF86AudioPlay}" = "{amixer -D pulse sset Master 5%- > /dev/null,amixer -D pulse sset Master 5%+ > /dev/null,playerctl previous,playerctl next,playerctl play-pause}";

      # wall
      "super + w" = "wall c +";
      "super + shift + w" = "wall c -";
    };

    extraConfig = ''
      # send the selected node to the given desktop
      super + shift +{1-6}
          desktop={1-6}; \
      	bspc node -d "$\{desktop\}.local"
      	for mon_id in $(bspc query -N -n); do \
              bspc node "$\{mon_id\}:focused#$\{desktop\}.local" -d; \
          done

      # focus on the selected desktop on the selected monitor
      super + {1-7}
          desktop={1-7}; \
      	bspc desktop "$\{desktop\}.local" -f
      	for mon_id in $(bspc query -M -m); do \
              bspc desktop "$\{mon_id\}:focused#$\{desktop\}.local" -f; \
          done
    '';
  };
}

{
  config,
  lib,
  pkgs,
  ...
}: let
  mod = config.wayland.windowManager.sway.config.modifier;
in {
  "${mod}+x" = "exec ${lib.getExe pkgs.foot}";
  "${mod}+r" = "exec ${lib.getExe pkgs.anyrun}";
  XF86AudioPlay = "exec ${lib.getExe pkgs.playerctl} play-pause";
  XF86AudioNext = "exec ${lib.getExe pkgs.playerctl} next";
  XF86AudioPrev = "exec ${lib.getExe pkgs.playerctl} previous";

  "${mod}+Shift+q" = "kill";

  "${mod}+z" = "floating toggle";
  "${mod}+f" = "fullscreen toggle";
  "${mod}+Shift+r" = "mode resize";

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

  "${mod}+h" = "focus left";
  "${mod}+j" = "focus down";
  "${mod}+k" = "focus up";
  "${mod}+l" = "focus right";

  "${mod}+Ctrl+h" = "move left";
  "${mod}+Ctrl+j" = "move down";
  "${mod}+Ctrl+k" = "move up";
  "${mod}+Ctrl+l" = "move right";

  "${mod}+Shift+h" = "resize shrink width 10px";
  "${mod}+Shift+j" = "resize shrink height 10px";
  "${mod}+Shift+k" = "resize grow height 10px";
  "${mod}+Shift+l" = "resize grow width 10px";
}

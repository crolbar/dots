{pkgs, ...}: {
  imports = [./scripts];

  xdg.configFile."niri/eww/eww.yuck".source = ./eww.yuck;
  xdg.configFile."niri/eww/eww.scss".source = ./eww.scss;
  xdg.configFile."niri/eww/btm_tray".source = ./btm_tray;
  xdg.configFile."niri/eww/bar".source = ./bar;
  xdg.configFile."niri/eww/tags".source = ./tags;

  home.packages = with pkgs; [eww];
}

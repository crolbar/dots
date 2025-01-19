{pkgs, ...}: {
  imports = [./scripts];

  xdg.configFile."bspwm/eww/eww.yuck".source = ./eww.yuck;
  xdg.configFile."bspwm/eww/eww.scss".source = ./eww.scss;

  home.packages = [pkgs.eww];
}

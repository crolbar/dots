{pkgs, ...}: {
  imports = [./scripts];

  xdg.configFile."hypr/eww/eww.yuck".source = ./eww.yuck;
  xdg.configFile."hypr/eww/eww.scss".source = ./eww.scss;

  home.packages = [pkgs.eww];
}

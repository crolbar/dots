{pkgs, ...}: {
  imports = [./scripts];

  xdg.configFile."river/eww/eww.yuck".source = ./eww.yuck;
  xdg.configFile."river/eww/eww.scss".source = ./eww.scss;
  xdg.configFile."river/eww/btm_tray".source = ./btm_tray;
  xdg.configFile."river/eww/tags".source = ./tags;

  home.packages = with pkgs; [
    eww
    ristate
  ];
}

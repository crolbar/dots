{
  config,
  lib,
  pkgs,
  ...
} @ attrs: {
  imports = [
    ../share/wayland
    ../share/wall
  ];

  wayland.windowManager.sway = {
    enable = true;

    config = import ./settings.nix attrs;

    extraOptions = ["--unsupported-gpu"];
  };
}

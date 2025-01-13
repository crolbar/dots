{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../share/wayland
    ../share/wall
  ];

  wayland.windowManager.sway = {
    enable = true;

    config = import ./settings.nix {inherit config lib pkgs;};

    extraOptions = ["--unsupported-gpu"];
  };
}

{...}: let
  config = ./settings.nix;
in {
  wayland.windowManager.sway = {
    enable = true;

    inherit config;

    extraOptions = ["--unsupported-gpu"];
  };
}

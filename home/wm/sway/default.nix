{
  imports = [
    ./binds.nix
    ./settings.nix

    ../share/wayland
    ../share/wall
  ];

  wayland.windowManager.sway = {
    enable = true;

    extraOptions = ["--unsupported-gpu"];
  };
}

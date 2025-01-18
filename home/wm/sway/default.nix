{
  imports = [
    ./binds.nix
    ./settings.nix

    ../share/wayland
    ../share/wall
    ../share/scripts
  ];

  wayland.windowManager.sway = {
    enable = true;

    extraOptions = ["--unsupported-gpu"];
  };
}

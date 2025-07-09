{
  pkgs,
  inputs',
  ...
}: {
  imports = [
    ./binds.nix
    ./settings.nix
    ./eww

    ../share/wayland
    ../share/dunst.nix
    ../share/wall
  ];

  home.packages = with pkgs; [
    xwayland-satellite
  ];

  programs.niri = {
    enable = true;
    package = inputs'.niri.packages.niri-stable;
  };
}

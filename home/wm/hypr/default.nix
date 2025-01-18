{
  hyprland,
  pkgs,
  ...
}: {
  imports = [
    hyprland.homeManagerModules.default
    ./binds.nix
    ./settings.nix
    ./eww
    ./scripts

    ../share/scripts
    ../share/wayland
    ../share/dunst.nix
    ../share/wall
  ];

  home.packages = [pkgs.polkit_gnome];

  wayland.windowManager.hyprland.enable = true;
}

{
  #hyprland,
  pkgs,
  ...
}: {
  imports = [
    #hyprland.homeManagerModules.default
    ./binds.nix
    ./settings.nix

    ../share/wayland
    ../share/dunst.nix
    ../share/wall
  ];

  home.packages = with pkgs; [
    polkit_gnome
    eww
    scriptisto # for c scripts
  ];

  xdg.configFile."hypr/eww".source = ./eww;
  xdg.configFile."hypr/scripts".source = ./scripts;

  wayland.windowManager.hyprland.enable = true;
}

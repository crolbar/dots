{
  hyprland,
  pkgs,
  ...
}: {
  imports = [
    hyprland.homeManagerModules.default
    ./binds.nix
    ./settings.nix

    ../share/dunst.nix
  ];

  home.packages = with pkgs; [
    anyrun
    swaylock
    eww
    swaybg
  ];

  xdg.configFile."hypr/anyrun".source = ./anyrun;
  xdg.configFile."hypr/eww".source = ./eww;
  xdg.configFile."hypr/scripts".source = ./scripts;
  xdg.configFile."hypr/wallpapers".source = ./wallpapers;

  wayland.windowManager.hyprland.enable = true;
}

{pkgs, ...}: {
  imports = [
    ./binds.nix
    ./settings.nix
    ./eww
    ./scripts

    ../share/scripts
    ../share/wayland
    ../share/dunst.nix
    ../share/wall
  ];

  home.packages = [
    pkgs.polkit_gnome
    (pkgs.writers.writeBashBin "hypr" ''
      uwsm start hyprland.desktop
    '')
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    # portalPackage = null;
  };
}

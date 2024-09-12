{pkgs, ...}: {
  imports = [
    ./binds.nix
    ./settings.nix
    ./kanshi.nix
    ./eww

    ../share/wayland
    ../share/dunst.nix
    ../share/wall
  ];

  home.packages = with pkgs; [
    polkit_gnome
    wideriver # layout generator
    lswt # shows title & app-id of views
  ];

  wayland.windowManager.river = {
    enable = true;

    extraSessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
    };
  };
}

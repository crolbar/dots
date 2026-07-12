{pkgs, ...}: {
  imports = [
    ./fuzzel.nix
  ];
  home.packages = with pkgs; [
    awww
    hyprpicker
    wl-clipboard
    grim
    slurp
    wayland-utils

    nwg-look # maybe unneeded
  ];

  programs = {
    swaylock.enable = true;
  };
}

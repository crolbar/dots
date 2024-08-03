{pkgs, ...}: {
  home.packages = with pkgs; [
    anyrun
    swaylock
    swww
    hyprpicker
    wl-clipboard
    grim
    slurp

    nwg-look # maybe unneeded
  ];
}

{pkgs, ...}: {
  imports = [
    ./anyrun.nix
  ];
  home.packages = with pkgs; [
    swww
    hyprpicker
    wl-clipboard
    grim
    slurp

    nwg-look # maybe unneeded
  ];

  programs = {
    swaylock.enable = true;
  };
}

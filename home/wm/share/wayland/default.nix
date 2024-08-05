{pkgs, ...}: {
  home.packages = with pkgs; [
    anyrun
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

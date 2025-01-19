{pkgs, ...}: {
  home.packages = with pkgs; [
    xclip
    xcolor
    i3lock
    shutter
    feh

    lxappearance # maybe unneeded
  ];
}

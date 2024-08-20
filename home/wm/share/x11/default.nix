{pkgs, ...}: {
  home.packages = with pkgs; [
    xclip
    xcolor
    i3lock
    flameshot
    feh

    lxappearance # maybe unneeded
  ];
}

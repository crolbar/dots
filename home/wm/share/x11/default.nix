{pkgs, ...}: {
  home.packages = with pkgs; [
    xclip
    xcolor
    i3lock
    flameshot

    lxappearance # maybe unneeded
  ];
}

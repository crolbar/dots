{pkgs, ...}: {
  home.packages = with pkgs; [
    wine64
    fuse
    fuse-overlayfs
    psmisc
  ];
}

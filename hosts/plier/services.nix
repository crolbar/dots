{pkgs, ...}: {
  services = {
    sshd.enable = true;
    gvfs.enable = true;
    playerctld.enable = true;
    tailscale.enable = true;

    xserver = {
      enable = true;
      windowManager = {
        bspwm.enable = true;
        leftwm.enable = false; # if I use overlay and enable this it breaks systemd
      };
      displayManager = {
        startx.enable = true;
      };
    };

    printing = {
      enable = true;
      drivers = [pkgs.splix];
    };
  };
}

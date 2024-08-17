{...}: {
  services = {
    sshd.enable = true;
    gvfs.enable = true;
    playerctld.enable = true;

    xserver = {
      enable = true;
      windowManager.bspwm.enable = true;
      windowManager.leftwm.enable = true;
      displayManager.startx.enable = true;
    };
  };
}

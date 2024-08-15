{username, ...}: {
  services = {
    sshd.enable = true;

    gvfs.enable = true;

    syncthing = {
      user = username;
      enable = true;
      systemService = false;
    };

    playerctld.enable = true;

    xserver = {
      enable = true;
      windowManager.bspwm.enable = true;
      windowManager.leftwm.enable = true;
      displayManager.startx.enable = true;
      desktopManager.xterm.enable = false;
    };
  };
}

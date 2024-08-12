{username, ...}: {
  services = {
    xserver = {
      enable = true;
      windowManager.bspwm.enable = true;
      windowManager.leftwm.enable = true;
      displayManager.startx.enable = true;
      desktopManager.xterm.enable = false;
    };

    getty.autologinUser = username;
    sshd.enable = true;
  };
}

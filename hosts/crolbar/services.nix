{
  services = {
    sshd.enable = true;
    ddccontrol.enable = true;
    hardware.openrgb.enable = true;

    tumbler.enable = true;
    gvfs.enable = true;
    tlp.enable = true;

    syncthing = {
      user = "crolbar";
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
    xserver.videoDrivers = ["nvidia"];

    pipewire.enable = true;

    getty.autologinUser = "crolbar";
  };
}

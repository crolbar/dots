{username, ...}: {
  services = {
    xserver = {
      enable = true;
      windowManager = {
        bspwm.enable = true;
        leftwm.enable = true;
      };
      displayManager = {
        startx.enable = true;
      };
    };

    getty.autologinUser = username;
    sshd.enable = true;
  };
}

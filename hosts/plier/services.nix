{...}: {
  services = {
    sshd.enable = true;
    gvfs.enable = true;
    playerctld.enable = true;

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
  };
  programs.hyprland.enable = true;
}

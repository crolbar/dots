{
  pkgs,
  lib,
  ...
}: {
  services = {
    sshd.enable = true;
    gvfs.enable = true;
    playerctld.enable = true;
    tailscale.enable = true;

    dbus.implementation = "broker";

    xserver = {
      enable = false;
      windowManager = {
        bspwm.enable = false;
        leftwm.enable = false; # if I use overlay and enable this it breaks systemd
      };
      displayManager = {
        startx.enable = false;
      };
    };

    printing = {
      enable = true;
      drivers = [pkgs.splix];
    };
    gnome.gnome-keyring.enable = lib.mkForce false;
  };
}

{
  username,
  pkgs,
  lib,
  ...
}: {
  services = {
    sshd.enable = true;
    ddccontrol.enable = true;
    hardware.openrgb.enable = true;
    tailscale.enable = true;

    gvfs.enable = true;
    # thumbnails thunar + risteretto
    tumbler.enable = true;

    # playerctld.enable = true;
    gnome.gnome-keyring.enable = lib.mkForce false;

    auto-cpufreq.enable = true;

    xserver = {
      enable = true;
      windowManager = {
        i3.enable = true;
      };
      displayManager = {
        startx.enable = true;
      };
      # desktopManager = {
      #   xfce = {
      #     enable = false;
      #     enableXfwm = false;
      #   };
      # };

      dpi = 96;

      videoDrivers = [
        "amdgpu"
        "nvidia"
      ];
    };

    libinput.mouse = {
      accelSpeed = "-0.4";
      accelProfile = "flat";
    };

    getty.autologinUser = username;

    # mysql = {
    #   enable = true;
    #   package = pkgs.mariadb;
    # };

    # postgresql = {
    #   enable = true;
    # };

    udev = {
      packages = [
        pkgs.oversteer

        (pkgs.writeTextFile {
          name = "kvmfr";
          text = ''
            SUBSYSTEM=="kvmfr", GROUP="kvm", MODE="0660", TAG+="uaccess"
          '';
          destination = "/etc/udev/rules.d/70-kvmfr.rules";
        })
      ];
    };
  };
}

{
  username,
  pkgs,
  ...
}: {
  services = {
    sshd.enable = true;
    ddccontrol.enable = true;
    hardware.openrgb.enable = true;

    gvfs.enable = true;

    playerctld.enable = true;

    xserver = {
      enable = true;
      windowManager = {
        bspwm.enable = true;
      };
      displayManager = {
        startx.enable = true;
      };
      desktopManager = {
        xfce = {
          enable = false;
          enableXfwm = false;
        };
      };

      dpi = 96;
      screenSection = ''
        Option "metamodes" "DP-0: 1920x1080_144 +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, HDMI-0: nvidia-auto-select +0+70 {rotation=right, ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-2: nvidia-auto-select +1080+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
      '';

      monitorSection = ''
        Option "DPMS" "false"
      '';

      serverFlagsSection = ''
        Option "StandbyTime" "0"
        Option "SuspendTime" "0"
        Option "OffTime" "0"
        Option "BlankTime" "0"
      '';

      videoDrivers = ["nvidia"];
    };

    libinput.mouse = {
      accelSpeed = "-0.4";
      accelProfile = "flat";
    };

    getty.autologinUser = username;

    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };

    postgresql = {
      enable = true;
    };

    udev.packages = with pkgs; [oversteer];
  };
}

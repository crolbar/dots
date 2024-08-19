{username, ...}: {
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
        leftwm.enable = true;
      };
      displayManager = {
        startx.enable = true;
      };
      dpi = 96;
      screenSection = ''
        Option "metamodes" "DP-0: 1920x1080_144 +1080+1080 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, HDMI-0: nvidia-auto-select +0+70 {rotation=right, ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-2: nvidia-auto-select +1080+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
      '';
    };
    xserver.videoDrivers = ["nvidia"];
    libinput.mouse = {
      accelSpeed = "-0.4";
      accelProfile = "flat";
    };

    getty.autologinUser = username;
  };
  programs.hyprland.enable = true;
}

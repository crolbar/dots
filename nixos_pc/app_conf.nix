{
  hyprland,
  pkgs,
  ...
}: {
  imports = [
    hyprland.nixosModules.default
  ];

  services.xserver = {
    enable = true;
    windowManager.bspwm.enable = true;
    displayManager.startx.enable = true;
    desktopManager.xterm.enable = false;
    resolutions = [
      {
        x = 1920;
        y = 1080;
      }
    ];
  };

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
  };
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  programs.hyprland.enable = true;

  services.getty.autologinUser = "crolbar";
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    config = {
      init = {defaultBranch = "master";};
      user = {
        name = "crolbar";
        email = "crolbar@crolbar.com";
      };
      url."https://github.com/".insteadOf = ["gh:"];
      credential.helper = "store";
    };
  };

  programs.steam.enable = true;

  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;
  programs.virt-manager.enable = true;

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [thunar-archive-plugin thunar-volman];
  };
}

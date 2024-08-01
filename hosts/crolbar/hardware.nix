{
  pkgs,
  config,
  ...
}: {
  hardware = {
    pulseaudio = {
      package = pkgs.pulseaudioFull;
      enable = true;
      support32Bit = true;
      daemon.config = {
        flat-volumes = "yes";
      };
    };

    bluetooth.enable = false;
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      nvidiaSettings = true;
      modesetting.enable = true;
      powerManagement.enable = true;
    };
  };

  fileSystems."/arch" = {
    device = "/dev/disk/by-uuid/4a7b5c17-3256-4f7c-b475-56d85727f6f8";
    fsType = "ext4";
  };
}

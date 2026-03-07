{
  config,
  lib,
  ...
}: {
  zramSwap = {
    enable = true;
    memoryPercent = 100;

    algorithm = "ztsd";
    priority = 100;
  };

  hardware = {
    bluetooth.enable = false;
    nvidia = {
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/os-specific/linux/nvidia-x11/default.nix
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      open = false;
      modesetting.enable = true;
      powerManagement.enable = true;
    };

    enableRedistributableFirmware = lib.mkDefault true;
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}

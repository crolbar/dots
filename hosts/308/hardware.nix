{
  config,
  lib,
  pkgs,
  ...
}: {
  hardware = {
    bluetooth.enable = false;
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      nvidiaSettings = true;
      open = false;
      modesetting.enable = true;
      powerManagement.enable = true;
      nvidiaPersistenced = true;
      forceFullCompositionPipeline = true;
    };

    graphics.extraPackages = with pkgs; [nvidia-vaapi-driver];

    enableRedistributableFirmware = lib.mkDefault true;
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}

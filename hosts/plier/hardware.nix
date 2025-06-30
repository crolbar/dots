{
  pkgs,
  config,
  lib,
  ...
}: {
  hardware = {
    bluetooth.enable = true;

    enableRedistributableFirmware = lib.mkDefault true;
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    sane = {
      enable = true;
      extraBackends = [pkgs.sane-backends];
    };
  };
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}

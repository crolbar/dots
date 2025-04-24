{
  config,
  lib,
  ...
}: {
  hardware = {
    bluetooth.enable = true;

    enableRedistributableFirmware = lib.mkDefault true;
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}

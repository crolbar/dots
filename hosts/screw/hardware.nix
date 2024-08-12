{lib, ...}: {
  hardware.enableRedistributableFirmware = lib.mkDefault true;
}

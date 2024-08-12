{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
    fsType = "ext4";
  };

  fileSystems."/boot/firmware" = {
    device = "/dev/disk/by-uuid/2178-694E";
    fsType = "vfat";
    options = ["nofail" "noauto"];
  };

  fileSystems."/nas" = {
    device = "/dev/disk/by-uuid/0de20af8-447e-4f8f-86ba-3e9ccbbe4bb6";
    fsType = "ext4";
    options = ["noatime" "nodiratime" "commit=60" "barrier=1"];
  };

  swapDevices = [
    {
      device = "/.swapfile";
    }
  ];
}

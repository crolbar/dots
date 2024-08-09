{config, ...}: {
  hardware = {
    bluetooth.enable = false;
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      nvidiaSettings = true;
      modesetting.enable = true;
      powerManagement.enable = true;
    };
  };

  fileSystems."/arch" = {
    device = "/dev/disk/by-uuid/4a7b5c17-3256-4f7c-b475-56d85727f6f8";
    fsType = "ext4";
    options = ["users" "nofail" "exec"];
  };

  #fileSystems."/mnt/nas" = {
  #  device = "192.168.1.11:/nas";
  #  fsType = "nfs";
  #  options = ["rw" "async"];
  #};
}

{...}: {
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/4bcc104a-8fc4-4ddd-badd-0a97337a6e1d";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/F9B5-B9C5";
      fsType = "vfat";
    };

    "/mnt/nas" = {
      device = "192.168.1.11:/nas";
      fsType = "nfs";
      options = ["rw"];
    };
  };
}

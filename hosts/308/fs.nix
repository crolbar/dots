{...}: {
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/42bbb9c0-c03e-4056-968d-f6c054417620";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/837f1a28-b515-48aa-9d2e-72514a9a4e1f";
      fsType = "ext4";
    };

    "/mnt/nas" = {
      device = "192.168.1.11:/nas";
      fsType = "nfs";
      options = ["rw"];
    };
  };
}

{...}: {
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/9350e853-b4c8-4783-a61d-180ff5aa5ca8";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/c2978a15-c87a-4d41-90ca-d17821586716";
      fsType = "ext4";
    };

    "/arch" = {
      device = "/dev/disk/by-uuid/4a7b5c17-3256-4f7c-b475-56d85727f6f8";
      fsType = "ext4";
      options = ["users" "nofail" "exec"];
    };

    "/mnt/nas" = {
      device = "192.168.1.11:/nas";
      fsType = "nfs";
      options = ["rw"];
    };
  };
}

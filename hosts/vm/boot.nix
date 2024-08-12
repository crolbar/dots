{
  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = false;
        device = "/dev/sda";
      };
    };
    kernelParams = ["quiet"];

    initrd.availableKernelModules = [
      # from nixos/modules/profiles/qemu-guest.nix
      "virtio_net"
      "virtio_pci"
      "virtio_mmio"
      "virtio_blk"
      "virtio_scsi"
      "9p"
      "9pnet_virtio"

      "ahci"
      "xhci_pci"
      "virtio_pci"
      "virtio_scsi"
      "sd_mod"
      "sr_mod"
    ];

    kernelModules = [
      # from nixos/modules/profiles/qemu-guest.nix
      "virtio_balloon"
      "virtio_console"
      "virtio_rng"
      "virtio_gpu"

      "kvm-amd"
    ];
  };
}

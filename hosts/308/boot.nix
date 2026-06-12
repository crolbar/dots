{
  darkmatter-grub-theme,
  config,
  pkgs,
  ...
}: {
  imports = [darkmatter-grub-theme.nixosModule];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

    kernel.sysctl = {
      "kernel.nmi_watchdog" = 0;
      "kernel.soft_watchdog" = 0;
      "kernel.watchdog" = 0;
    };

    loader = {
      grub = {
        enable = true;
        efiSupport = false;
        device = "/dev/nvme0n1";

        darkmatter-theme = {
          enable = true;
          style = "nixos";
          icon = "color";
          resolution = "1080p";
        };
      };
    };

    kernelParams = [
      "quiet"
      "nowatchdog"
      "acpi_enforce_resources=lax" # needed for openrgb in aorus MOBOs
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1" # fixes hyprland crash on suspend wakeup
      "amd_iommu=on" # pcie passthrough

      "pcie_acs_override=downstream,multifunction" # separate iommu groups

      "kvmfr.static_size_mb=128"
      # "vfio-pci.ids=1002:67b0,1002:aac8,144d:a80a" # use to bind device to vfio drivers
    ];

    kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
      "kvmfr" # looking glass
      "kvm-amd"
    ];

    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];

    extraModulePackages = [config.boot.kernelPackages.kvmfr];

    blacklistedKernelModules = [
      "nouveau"
      "uvcvideo"
    ];

    supportedFilesystems = ["ntfs"];

    binfmt.emulatedSystems = ["aarch64-linux"];
  };
}

{
  darkmatter-grub-theme,
  config,
  pkgs,
  ...
}: {
  imports = [darkmatter-grub-theme.nixosModule];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

    # cachyos tweaks
    kernel.sysctl = {
      "kernel.nmi_watchdog" = 0;
      "kernel.soft_watchdog" = 0;
      "kernel.watchdog" = 0;
      "vm.swappiness" = 150;
      "vm.vfs_cache_pressure" = 50;
      "vm.dirty_bytes" = 268435456;
      "vm.page-cluster" = 0;
      "vm.dirty_background_bytes" = 67108864;
      "vm.dirty_writeback_centisecs" = 1500;
      "kernel.unprivileged_userns_clone" = 1;
      "kernel.kptr_restrict" = 2;
      "net.core.netdev_max_backlog" = 4096;
      "fs.file-max" = 2097152;
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

    # cachyos tweaks
    # https://github.com/AniviaFlome/cachy-tweaks-flake/blob/main/modules/modprobe.nix
    extraModprobeConfig = ''
      # NVIDIA driver tweaks
      options nvidia NVreg_UsePageAttributeTable=1
      options nvidia NVreg_InitializeSystemMemoryAllocations=0
      options nvidia NVreg_DynamicPowerManagement=0x02

      # Force AMDGPU on Southern Islands (GCN 1.0) and Sea Islands (GCN 2.0)
      options amdgpu si_support=1 cik_support=1
      options radeon si_support=0 cik_support=0

      # Blacklist watchdog modules
      blacklist iTCO_wdt
      blacklist sp5100_tco
    '';
  };
}

{
  darkmatter-grub-theme,
  chaotic,
  pkgs,
  ...
}: {
  imports = [
    darkmatter-grub-theme.nixosModule
    chaotic.nixosModules.default
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;

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

    blacklistedKernelModules = [
      "nouveau"
      "uvcvideo"
    ];
    kernelParams = [
      "quiet"
      "nowatchdog"
      "acpi_enforce_resources=lax" # needed for openrgb in aorus MOBOs
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1" # fixes hyprland crash on suspend wakeup
    ];
    kernelModules = ["kvm-amd"];

    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];

    # cachyos tweaks
    # https://github.com/AniviaFlome/cachy-tweaks-flake/blob/main/modules/modprobe.nix
    extraModprobeConfig = ''
      # NVIDIA driver tweaks
      options nvidia NVreg_UsePageAttributeTable=1
                    NVreg_InitializeSystemMemoryAllocations=0
                    NVreg_DynamicPowerManagement=0x02

      # Force AMDGPU on Southern Islands (GCN 1.0) and Sea Islands (GCN 2.0)
      options amdgpu si_support=1 cik_support=1
      options radeon si_support=0 cik_support=0

      # Blacklist watchdog modules
      blacklist iTCO_wdt
      blacklist sp5100_tco
    '';
  };

  systemd.settings = {
    Manager = {
      DefaultTimeoutStartSec = "15s";
      DefaultTimeoutStopSec = "10s";
      DefaultLimitNOFILE = "2048:2097152";
    };
  };
}

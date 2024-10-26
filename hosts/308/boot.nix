{
  pkgs,
  darkmatter-grub-theme,
  ...
}: {
  imports = [darkmatter-grub-theme.nixosModule];

  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;

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

    blacklistedKernelModules = ["uvcvideo"];
    kernelParams = [
      "quiet"
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
  };
}

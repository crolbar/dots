{
  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = false;
        device = "/dev/sdb";
        theme = "/boot/grub/themes/theme/darkmatter";
      };
    };
    blacklistedKernelModules = ["uvcvideo"];
    kernelParams = [
      "quiet"
      "acpi_enforce_resources=lax" # needed for openrgb in aorus MOBOs
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1" # fixes hyprland crash on suspend wakeup
    ];
  };
}

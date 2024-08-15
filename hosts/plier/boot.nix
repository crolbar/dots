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
        efiSupport = true;
        device = "nodev";

        darkmatter-theme = {
          enable = true;
          style = "nixos";
          icon = "color";
          resolution = "1440p";
        };
      };
    };

    blacklistedKernelModules = ["uvcvideo"];
    kernelParams = ["quiet"];

    kernelModules = ["kvm-intel"];

    initrd.availableKernelModules = ["vmd" "xhci_pci" "nvme" "usb_storage" "sd_mod"];
  };
}

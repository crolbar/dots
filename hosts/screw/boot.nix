{
  boot = {
    initrd.availableKernelModules = ["xhci_pci"];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };
}

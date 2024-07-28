{
    boot = {
        loader = {
            grub = { 
                enable = true;
                efiSupport = true;
                device = "nodev";
                theme = "/boot/grub/themes/theme/darkmatter";
            };
        };
        blacklistedKernelModules = ["uvcvideo"];
        kernelParams = [ "quiet" ];
    };
}
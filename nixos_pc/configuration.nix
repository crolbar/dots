{ config, pkgs, ... }:
{
    system.stateVersion = "24.11";
    nixpkgs.config.allowUnfree = true;

    nix = {
        settings = {
            experimental-features = [ "nix-command" "flakes" ];
            auto-optimise-store = true;
            cores = 8;
        };

        gc.automatic = true;
        gc.dates = "weekly";
        gc.options = "--delete-older-than 15d";
    };

    environment.variables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        BROWSER = "floorp";
        TERMINAL = "alacritty";
    };

    boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

    hardware = {
        pulseaudio.enable = true;
        bluetooth.enable = false;
        nvidia = {
            package = config.boot.kernelPackages.nvidiaPackages.beta;
            nvidiaSettings = true;
            modesetting.enable = true;
            powerManagement.enable = true;
        };
    };
    services.xserver.videoDrivers = [ "nvidia" ];

    services.pipewire.enable = true;
    security.sudo.wheelNeedsPassword = false;

    fileSystems."/arch" =
        { device = "/dev/disk/by-uuid/4a7b5c17-3256-4f7c-b475-56d85727f6f8";
            fsType = "ext4";
        };
}

#                 (_ )( )               
#   ___ _ __   _   | || |_     _ _ _ __ 
# / ___)  __)/ _ \ | ||  _ \ / _  )  __)
#( (___| |  ( (_) )| || |_) ) (_| | |   
# \____)_)   \___/(___)_ __/ \__ _)_)   

{ config, pkgs, ... }:
{
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    imports = [ 
        ./hardware-configuration.nix
        ./packages.nix
        ./boot.nix
        ./locales.nix
        ./user.nix
    ];

    environment.variables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        BROWSER = "brave";
        TERMINAL = "alacritty";
        PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    };

    networking.hostName = "nixos"; 
    networking.networkmanager.enable = true;

    sound.enable = true;
    hardware = {
        pulseaudio.enable = true;
        bluetooth.enable = false;
    };

    services.xserver = { 
        enable = true;
        windowManager.leftwm.enable = true;
        displayManager.sddm.enable = true;
        desktopManager.xterm.enable = false;
    };


    security.sudo.wheelNeedsPassword = false;

    services.tumbler.enable = true;
    services.gvfs.enable = true;
    programs.thunar.plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];






    fonts.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "Hack" ]; })
    ];

    nixpkgs.config.allowUnfree = true;

    programs.neovim = {
        enable = true;
        configure = {
            packages.nixbundle.start = with pkgs.vimPlugins; [
                nvim-cmp
                nvim-lspconfig
            ];
        };
    };
    #system.autoUpgrade.enable = true;
    #system.autoUpgrade.channel = "https://nixos.org/channels/nixpkgs-unstable";

    nix.settings.auto-optimise-store = true;
    nix = {
        gc.automatic = true;
        gc.dates = "weekly";
        gc.options = "--delete-older-than 15d";
    };
# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
# services.openssh.enable = true;
# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    programs.ssh.askPassword = "";
    system.stateVersion = "23.05"; # Did you read the comment?

}


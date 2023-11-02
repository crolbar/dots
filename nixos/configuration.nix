#                 (_ )( )               
#   ___ _ __   _   | || |_     _ _ _ __ 
# / ___)  __)/ _ \ | ||  _ \ / _  )  __)
#( (___| |  ( (_) )| || |_) ) (_| | |   
# \____)_)   \___/(___)_ __/ \__ _)_)   

{ config, pkgs, ... }:

{
    imports = [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
    ];

    environment.variables = {
        EDITOR = "nvim";
        BROWSER = "brave";
        TERMINAL = "alacritty";
    };

#boot.loader.systemd-boot.enable = true;
    boot.loader = {
        efi = {
            canTouchEfiVariables = true;
            efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
        };
        grub = { 
            enable = true;
            efiSupport = true;
            device = "nodev";
            theme = "/boot/grub/themes/theme/darkmatter/";
        };
    };


    networking.hostName = "nixos"; 
#networking.wireless.enable = true; 


# Enable networking
    networking.networkmanager.enable = true;

    time.timeZone = "Europe/Sofia";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    services.xserver.displayManager.defaultSession = "none+leftwm";
    services.xserver.displayManager.autoLogin.enable = false;
    services.xserver.displayManager.sddm.enable = true;
    services.xserver.windowManager.leftwm.enable = true;
    services.xserver = { 
        enable = true;
        layout = "us";
        xkbVariant = "";
        desktopManager.xterm.enable = false;
    };

    programs.zsh.enable = true;

    sound.enable = true;
    hardware.pulseaudio.enable = true;

    services.xserver.libinput.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.crolbar = {
        isNormalUser = true;
        description = "crolbar";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [];

    };
    security.sudo.wheelNeedsPassword = false;

    users.extraUsers.crolbar = {
        shell = pkgs.zsh;
    };


    programs.thunar.enable = true;
    services.tumbler.enable = true; # Thumbnail support for images
        services.gvfs.enable = true; # Mount, trash, and other functionalities
        programs.thunar.plugins = with pkgs.xfce; [
        thunar-archive-plugin
            thunar-volman
        ];








    fonts.fonts = with pkgs; [
        (nerdfonts.override { fonts = [ "Hack" ]; })
    ];

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        vim 
            git
            zsh
            lsd
            fd
            btop
            htop
            neofetch
            neovim
            brightnessctl
            light
            pamixer
            i3lock
            tldr

            leftwm

            alacritty

            picom
            eww
            feh
            dunst
            rofi

            firefox
            brave
            vscodium
            gnome.file-roller

            pavucontrol
            xclip
            lxappearance
            capitaine-cursors
            xfce.thunar

            discord
            keepassxc

            roboto
            font-awesome
            hack-font

            lua-language-server
            nodejs
            clang-tools
            gcc
            cargo
            rustc
            rustup
            rust-analyzer
            python311
            python311Packages.pip
            nodePackages.pyright
            nodePackages_latest.bash-language-server
            nodePackages_latest.vscode-langservers-extracted

    ];


    system.autoUpgrade.enable = true;

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

#                 (_ )( )               
#   ___ _ __   _   | || |_     _ _ _ __ 
# / ___)  __)/ _ \ | ||  _ \ / _  )  __)
#( (___| |  ( (_) )| || |_) ) (_| | |   
# \____)_)   \___/(___)_ __/ \__ _)_)   

{ config, pkgs, nixpkgs, ... }:
{
    system.stateVersion = "23.05";
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
        BROWSER = "brave";
        TERMINAL = "alacritty";
    };

    hardware = {
        pulseaudio.enable = true;
        bluetooth.enable = false;
    };

    sound.enable = true;
    security.sudo.wheelNeedsPassword = false;
}

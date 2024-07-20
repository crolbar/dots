{ ... }:
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
        BROWSER = "floorp";
        TERMINAL = "alacritty";
    };

    hardware = {
        pulseaudio.enable = true;
        bluetooth.enable = false;
    };

    sound.enable = true;
    security.sudo.wheelNeedsPassword = false;
}

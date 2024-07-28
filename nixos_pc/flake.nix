{
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        rust-overlay.url = "github:oxalica/rust-overlay";
        nur.url = "github:nix-community/NUR";
        hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

        dapu.url = "github:crolbar/dapu";
        matm.url = "github:crolbar/matm";
        tt-rs.url = "github:crolbar/tt-rs";
        npassm.url = "github:crolbar/npassm";
        lobster.url = "github:justchokingaround/lobster";
    };

    outputs = inputs@{ 
        nixpkgs,
        ...} : {
        nixosConfigurations = {
            crolbar = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = inputs;
                modules = [ 
                    ./configuration.nix
                    ./hardware-configuration.nix
                    ./packages.nix
                    ./boot.nix
                    ./locales.nix
                    ./user.nix
                    ./app_conf.nix
                    ./net.nix
                    ./overlays.nix
                ];
            };
        };
    };
}

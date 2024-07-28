{
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        rust-overlay.url = "github:oxalica/rust-overlay";
        nur.url = "github:nix-community/NUR";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
		yazi.url = "github:sxyazi/yazi";

        dapu.url = "github:crolbar/dapu";
        matm.url = "github:crolbar/matm";
        tt-rs.url = "github:crolbar/tt-rs";
        npassm.url = "github:crolbar/npassm";
        lobster.url = "github:justchokingaround/lobster";
    };

    outputs = inputs@{ 
        nixpkgs,
        home-manager,
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

        homeConfigurations = {
            "crolbar@308" = home-manager.lib.homeManagerConfiguration {
                extraSpecialArgs = inputs;
                pkgs = nixpkgs.legacyPackages.x86_64-linux;
                modules = [
                    ./home.nix
                ];
            };
        };
    };
}

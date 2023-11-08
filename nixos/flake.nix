{
    description = "retart";

    outputs = { nixpkgs, rust-overlay, ... }: {
        nixosConfigurations = {
            crowbar = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [ 
                    ./configuration.nix 
                    ./hardware-configuration.nix
                    ./packages.nix
                    ./boot.nix
                    ./locales.nix
                    ./user.nix
                    ./app_conf.nix
                    ./net.nix

                    ({ pkgs, ... }: {
                        nixpkgs.overlays = [ rust-overlay.overlays.default ];
                    })
                ];
            };
        };
    };

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        rust-overlay.url = "github:oxalica/rust-overlay";
    };
}

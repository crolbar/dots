{
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        rust-overlay.url = "github:oxalica/rust-overlay";
        nur.url = "github:nix-community/NUR";

        dapu.url = "github:crolbar/dapu";
        matm.url = "github:crolbar/matm";
        tt-rs.url = "github:crolbar/tt-rs";
    };

    outputs = { 
        nixpkgs,
        rust-overlay,
        nur,
        dapu,
        matm,
        tt-rs,
    ... } : {
        nixosConfigurations = {
            crolbar = nixpkgs.lib.nixosSystem {
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

                    {nixpkgs.overlays = [ 
                        (final: prev: { 
                            dapu = dapu.defaultPackage.x86_64-linux; 
                            matm = matm.defaultPackage.x86_64-linux; 
                            tt-rs = tt-rs.defaultPackage.x86_64-linux; 
                        }) 
                        rust-overlay.overlays.default 
                        nur.overlay
                    ];}
                ];
            };
        };
    };
}

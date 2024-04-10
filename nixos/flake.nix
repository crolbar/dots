{
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        rust-overlay.url = "github:oxalica/rust-overlay";

        dapu.url = "github:crolbar/dapu";
        matm.url = "github:crolbar/matm";
        tt-rs.url = "github:crolbar/tt-rs?rev=e3c50a9e2826f6d9b19dec7396b366b740e711fc";
    };

    outputs = { 
        nixpkgs,
        rust-overlay,
        dapu,
        matm,
        tt-rs,
    ... } : {
        nixosConfigurations = {
            plier = nixpkgs.lib.nixosSystem {
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
                        nixpkgs.overlays = [ 
                            (final: prev: { 
                                dapu = dapu.defaultPackage.x86_64-linux; 
                                matm = matm.defaultPackage.x86_64-linux; 
                                tt-rs = tt-rs.defaultPackage.x86_64-linux; 
                            }) 
                            rust-overlay.overlays.default 
                        ];
                    })
                ];
            };
        };
    };
}

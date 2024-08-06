{inputs, ...}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    specialArgs = inputs;
  in {
    vm = nixosSystem {
      system = "x86_64-linux";
      inherit specialArgs;
      modules = [
        ../shared/nix.nix
        ../shared/zsh.nix

        ./vm
      ];
    };

    crolbar = nixosSystem {
      system = "x86_64-linux";
      inherit specialArgs;
      modules = [
        ../shared
        ../overlays.nix
        inputs.hm.nixosModules.default

        {
          home-manager = {
            users.crolbar.imports = [
              ../home/cli
              ../home/cli/zzz.nix
              ../home/gui
              ../home/dev
              ../home/wm/bsp
              ../home/wm/hypr
              ../home/misc
              ../home/profiles/crolbar
              ../overlays.nix
            ];

            extraSpecialArgs = specialArgs;
          };
        }

        ./crolbar
      ];
    };
  };
}

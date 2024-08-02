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

        ./crolbar
      ];
    };
  };
}

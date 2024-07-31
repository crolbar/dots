{inputs, ...}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    specialArgs = inputs;
  in {
    vm = nixosSystem {
      system = "x86_64-linux";
      inherit specialArgs;

      modules = [
        ../shared

        ./vm/boot.nix
        ./vm/services.nix
        ./vm/security.nix
        ./vm/net.nix
        ./vm/user.nix
        ./vm/hardware-configuration.nix
      ];
    };
  };
}

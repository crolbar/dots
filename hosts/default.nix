{
  inputs,
  user_modules,
  withSystem,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;

    mkNixosSys = {
      username,
      hostname,
      modules,
      system,
      ...
    } @ args:
      withSystem system ({
        inputs',
        self',
        ...
      }: let
        specialArgs = inputs // {inherit inputs';};
      in
        nixosSystem {
          inherit specialArgs;
          modules =
            args.modules
            ++ [
              {networking.hostName = hostname;}
              inputs.hm.nixosModules.default

              {
                home-manager = {
                  users.${username}.imports = user_modules."${username}";
                  extraSpecialArgs = specialArgs;
                };
              }
              ./${hostname}
            ]
            ++ [
              ../shared/env.nix
            ];
        });
  in {
    vm = mkNixosSys {
      username = "kubo";
      hostname = "vm";
      system = "x86_64-linux";
      modules = [
        ../shared/nix.nix
        ../shared/thunar.nix
        ../shared/qt.nix
        ../shared/zsh.nix
        ../shared/fonts.nix
      ];
    };

    "308" = mkNixosSys {
      username = "crolbar";
      hostname = "308";
      system = "x86_64-linux";
      modules = [
        ../shared
        ../overlays.nix
      ];
    };

    screw = mkNixosSys {
      username = "screw";
      hostname = "screw";
      system = "aarch64-linux";
      modules = [
        ../shared/nix.nix
        ../shared/fonts.nix
        ../shared/zsh.nix
        ../shared/env.nix
      ];
    };
  };
}

{
  inputs,
  user_modules,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;

    specialArgs = inputs;

    mkNixosSys = {
      username,
      hostname,
      modules,
      ...
    } @ args:
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
      };
  in {
    vm = mkNixosSys {
      username = "kubo";
      hostname = "vm";
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
      modules = [
        ../shared
        ../overlays.nix
      ];
    };

    screw = mkNixosSys {
      username = "screw";
      hostname = "screw";
      modules = [
        ../shared/nix.nix
        ../shared/fonts.nix
        ../shared/zsh.nix
        ../shared/env.nix
      ];
    };
  };
}

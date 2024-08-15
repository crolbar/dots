{
  withSystem,
  inputs,
  lib,
  ...
}: let
  user_modules = import ../home/user_modules.nix;
  inherit (inputs.nixpkgs.lib) nixosSystem;
in {
  mkHome = {
    system,
    username,
    ...
  } @ args:
    withSystem system ({
      inputs',
      self',
      ...
    }: let
      extraSpecialArgs =
        inputs
        // {inherit inputs';}
        // {inherit username;};
    in
      inputs.hm.lib.homeManagerConfiguration {
        inherit extraSpecialArgs;
        pkgs = inputs.nixpkgs.legacyPackages."${args.system}";
        modules =
          user_modules."${username}"
          ++ [
            ../home/profiles/${username}
            ../home/profiles/home.nix
          ];
      });

  mkNixosSys = {
    username,
    hostname,
    modules ? [],
    system,
    ...
  } @ args:
    withSystem system ({
      inputs',
      self',
      ...
    }: let
      specialArgs =
        inputs
        // {inherit inputs';}
        // {inherit username;};
    in
      nixosSystem {
        inherit specialArgs;
        modules =
          args.modules
          ++ [
            {networking.hostName = hostname;}
            {nixpkgs.hostPlatform = lib.mkDefault system;}
            inputs.hm.nixosModules.default

            {
              home-manager = {
                extraSpecialArgs = specialArgs;
                users.${username}.imports =
                  user_modules."${username}"
                  ++ [
                    ../home/profiles/${username}
                    ../home/profiles/home.nix
                  ];
              };
            }
            ../hosts/${hostname}
          ]
          ++ [
            ../shared/env.nix
            ../shared/nix.nix
          ];
      });
}

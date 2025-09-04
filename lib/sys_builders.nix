{
  self,
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
    nonNixOS ? false,
    ...
  } @ args:
    withSystem system ({
      inputs',
      self',
      ...
    }: let
      clib = self.outputs.clib;

      extraSpecialArgs =
        inputs
        // {inherit inputs';}
        // {inherit username;}
        // {inherit nonNixOS;}
        // {inherit clib;};
    in
      inputs.hm.lib.homeManagerConfiguration {
        inherit extraSpecialArgs;
        pkgs = inputs.nixpkgs.legacyPackages."${args.system}";
        modules =
          user_modules."${username}"
          ++ [
            ../home/profiles/${username}
            ../home/profiles/home.nix
            ../modules/hm
          ]
          ++ clib.ifL nonNixOS [../home/non_nixos];
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
        // {inherit username;}
        // {inherit (self.outputs) clib;};
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
                    ../modules/hm
                  ];
              };
            }
            ../hosts/${hostname}
          ]
          ++ [
            ../hosts/shared/locales.nix
            ../hosts/shared/env.nix
            ../hosts/shared/nix.nix
            ../modules/nixos
          ];
      });
}

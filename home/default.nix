{inputs, ...}: let
  inherit (inputs.hm.lib) homeManagerConfiguration;
  extraSpecialArgs = inputs;
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  flake = {
    homeConfigurations = {
      vm = homeManagerConfiguration {
        inherit extraSpecialArgs pkgs;
        modules = [./vm];
      };
    };
  };
}

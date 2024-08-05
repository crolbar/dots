{inputs, ...}: let
  inherit (inputs.hm.lib) homeManagerConfiguration;

  user_modules = {
    crolbar = [
      ./cli
      ./cli/zzz.nix
      ./gui
      ./dev
      ./wm/bsp
      ./wm/hypr
      #./wm/left
      ./misc/xdg.nix
      ./misc/gtk.nix
      ../overlays.nix
      ./profiles/crolbar
    ];

    vm = [
      ./cli
      #./gui
      #./wm/left
      ./wm/bsp
      #./wm/hypr
      ./profiles/vm
      ./misc/xdg.nix
    ];
  };

  extraSpecialArgs = inputs;
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  flake = {
    homeConfigurations = {
      vm = homeManagerConfiguration {
        inherit extraSpecialArgs pkgs;
        modules = user_modules.vm;
      };

      crolbar = homeManagerConfiguration {
        inherit extraSpecialArgs pkgs;
        modules = user_modules.crolbar;
      };
    };
  };
}

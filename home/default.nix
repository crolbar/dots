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
      ./misc
      ../overlays.nix
      ./profiles/crolbar
    ];

    kubo = [
      ./cli
      ./dev

      ./gui/alacritty.nix
      ./gui/zathura.nix
      ./gui/eww
      ./gui/schizofox.nix

      ./wm/bsp
      ./wm/hypr
      ./misc
      ./profiles/vm
    ];
  };

  extraSpecialArgs = inputs;
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  _module.args = {inherit user_modules;};

  flake = {
    homeConfigurations = {
      kubo = homeManagerConfiguration {
        inherit extraSpecialArgs pkgs;
        modules = user_modules.kubo;
      };

      crolbar = homeManagerConfiguration {
        inherit extraSpecialArgs pkgs;
        modules = user_modules.crolbar;
      };
    };
  };
}

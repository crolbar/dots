{inputs, ...}: let
  user_modules = {
    crolbar = [
      ./cli
      ./cli/zzz.nix
      ./gui
      ./dev
      ./wm/bsp
      ./wm/hypr
      ./misc
      ../overlays.nix
      ./profiles/crolbar
      ./misc/mangohud.nix
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
      ./profiles/kubo
    ];

    screw = [
      ./cli
      ./profiles/screw
    ];
  };

  extraSpecialArgs = inputs;

  mkHome = {
    system,
    username,
    ...
  } @ args:
    inputs.hm.lib.homeManagerConfiguration {
      inherit extraSpecialArgs;
      pkgs = inputs.nixpkgs.legacyPackages."${system}";
      modules = user_modules."${username}";
    };
in {
  _module.args = {inherit user_modules;};

  flake = {
    homeConfigurations = {
      kubo = mkHome {
        system = "x86_64-linux";
        username = "kubo";
      };

      crolbar = mkHome {
        system = "x86_64-linux";
        username = "crolbar";
      };

      screw = mkHome {
        system = "aarch64-linux";
        username = "screw";
      };
    };
  };
}

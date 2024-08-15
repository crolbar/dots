{clib, ...}: let
  inherit (clib) mkNixosSys;
in {
  flake.nixosConfigurations = {
    vm = mkNixosSys {
      username = "kubo";
      hostname = "vm";
      system = "x86_64-linux";
      modules = [
        ../shared/gui
        ../shared/cli
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

    plier = mkNixosSys {
      username = "plier";
      hostname = "plier";
      system = "x86_64-linux";
      modules = [
        ../shared/virt
        ../shared/gui
        ../shared/cli
        ../overlays.nix
      ];
    };

    screw = mkNixosSys {
      username = "screw";
      hostname = "screw";
      system = "aarch64-linux";
      modules = [
        ../shared/cli
      ];
    };
  };
}

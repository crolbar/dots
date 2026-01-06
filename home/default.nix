{clib, ...}: let
  inherit (clib) mkHome;
in {
  flake.homeConfigurations = {
    kubo = mkHome {
      system = "x86_64-linux";
      username = "kubo";
    };

    crolbar = mkHome {
      system = "x86_64-linux";
      username = "crolbar";
    };

    plier = mkHome {
      system = "x86_64-linux";
      username = "plier";
    };

    screw = mkHome {
      system = "aarch64-linux";
      username = "screw";
    };

    pvm = mkHome {
      system = "x86_64-linux";
      username = "pvm";
      nonNixOS = true;
    };

    crolchy = mkHome {
      system = "x86_64-linux";
      username = "crolchy";
      nonNixOS = true;
    };

    win = mkHome {
      system = "x86_64-linux";
      username = "win";
      nonNixOS = true;
    };
  };
}

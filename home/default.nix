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
    };
  };
}

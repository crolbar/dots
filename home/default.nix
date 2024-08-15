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

    screw = mkHome {
      system = "aarch64-linux";
      username = "screw";
    };
  };
}

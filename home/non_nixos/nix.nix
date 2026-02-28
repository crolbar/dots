{pkgs, ...}: let
  origin = (import ../../hosts/shared/nix.nix {inherit pkgs;}).nix;

  newOrigin =
    builtins.removeAttrs
    origin
    [
      "daemonIOSchedClass"
      "daemonCPUSchedPolicy"
      "optimise"
      "gc"
    ];
in {
  nix = newOrigin;
}

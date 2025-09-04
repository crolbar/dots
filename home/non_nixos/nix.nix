{pkgs, ...}: let
  origin = (import ../../hosts/shared/nix.nix {inherit pkgs;}).nix;

  newOrigin =
    builtins.removeAttrs
    origin
    [
      "daemonIOSchedClass"
      "daemonCPUSchedPolicy"
      "optimise"
    ];

  renameGCDate = let
    oldGC = newOrigin.gc;
    newGC =
      (builtins.removeAttrs newOrigin.gc ["dates"])
      // {frequency = oldGC.dates;};
  in
    (builtins.removeAttrs newOrigin ["gc"]) // {gc = newGC;};
in {
  nix = renameGCDate;
}

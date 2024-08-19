{
  inputs',
  rust-overlay,
  ...
}: let
  ovrls =
    builtins.foldl' (acc: elem: acc // elem) {}
    (
      map (pname: {
        "${pname}" = inputs'."${pname}".packages.default;
      }) ["dapu" "matm" "tt-rs" "npassm" "lobster" "swww"]
    );
in {
  nixpkgs.overlays = [
    (final: prev: ovrls)
    rust-overlay.overlays.default
  ];
}

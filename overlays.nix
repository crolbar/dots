{
  inputs',
  rust-overlay,
  leftwm,
  ristate,
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
    ristate.overlays.default
    leftwm.overlays.default
    rust-overlay.overlays.default
  ];
}
